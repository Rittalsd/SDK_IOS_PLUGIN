//
//  PaymentViewController.swift
//  RitaPaySDK
//
//  Created by Jihad Mahmoud on 29/03/2021.
//

import Foundation
import UIKit

/// Payment view controller
public class PaymentViewController: UIViewController {
    
    /// Check out id: should be injected after loading view in memeory
    public var checkOutId: String? {
        didSet {
            loadData()
        }
    }
    /// Delegate weak variable to call delegate functions
    public weak var delegate: PaymentViewDelegate?
    /// The service manager singelton
    private let serviceManager = ServiceManager.shared
    /// Error returned from services
    private var error: Error?
    /// Public key returned from service
    private var publicKey: String?
    /// Payment Response returned from service
    private var paymentResponse: PaymentResponse?
    /// Loading indicator
    private var loadingIndicator: UIActivityIndicatorView?
    /// Payment information response returned from service
    private var paymentInformation: PaymentInformationResponse? {
        didSet {
            loadPaymentView()
        }
    }
    /// Payment view
    private var paymentView = PaymentView()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        loadData()
    }
}

extension PaymentViewController {
    /**
     Method to add loading indicator to the view controller
     */
    private func addLoadingIndicator() {
        loadingIndicator = UIActivityIndicatorView()
        guard let loadingIndicator = loadingIndicator else { return }
        loadingIndicator.style = .gray
        paymentView.addSubview(loadingIndicator)
        paymentView.bringSubviewToFront(loadingIndicator)
    }
    
    /**
     Method to load payment view
     */
    private func loadPaymentView() {
        paymentView.paymentInformation = paymentInformation
        view = paymentView
        paymentView.textFieldsDidFinishedEntered = { [weak self] (pan, ipin, expiry) in
            if Validation.shared.panValidation(panString: pan) {
                if Validation.shared.expiryDateValidation(dateString: expiry) {
                    if Validation.shared.iPinValidation(pinString: ipin) {
                        let expiryDate = expiry.replacingOccurrences(of: "/", with: "")
                        self?.doPayment(with: pan, expiryDate: expiryDate, pin: ipin)
                    } else {
                        let alert = Validation.shared.validationAlert(for: .ipin)
                        self?.present(alert, animated: true, completion: nil)
                    }
                } else {
                    let alert = Validation.shared.validationAlert(for: .expiryDate)
                    self?.present(alert, animated: true, completion: nil)
                }
            } else {
                let alert = Validation.shared.validationAlert(for: .pan)
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    /**
     Method to do the payment for the checkout id with the card details provided
     - parameters:
        - pan: the card number (PAN)
        - expiryDate: the card expiry date YY/MM
        - ipin: the card iPIN clear text
     */
    private func doPayment(with pan: String, expiryDate: String, pin: String) {
        addLoadingIndicator()
        loadingIndicator?.startAnimating()
        guard let publicKey = publicKey, let checkOutId = checkOutId, let encryptedPIN = Encryption.shared.encryptUserDataString(with: publicKey, uuid: checkOutId, userDataString: pin) else {
            loadingIndicator?.stopAnimating()
            return
        }
        let parametersObject = PaymentRequest(checkOutId: checkOutId, pan: pan, expiryDate: expiryDate, iPin: encryptedPIN)
        serviceManager.networkRequest(for: .doPayment, encodingData: parametersObject) { [weak self] (paymentResponse: PaymentResponse?, error) in
            guard error == nil else {
                self?.loadingIndicator?.stopAnimating()
                self?.delegate?.didFinishPayment(didAbortWithError: error!)
                return
            }
            
            self?.loadingIndicator?.stopAnimating()
            self?.paymentResponse = paymentResponse
            self?.delegate?.didFinishPayment(paymentResponse)
        }
    }
}

extension PaymentViewController {
    /**
     Private Helper method to load the data
     */
    fileprivate func loadData() {
        addLoadingIndicator()
        loadingIndicator?.startAnimating()
        let dispatchGroup = DispatchGroup()
        
        let publicKeyRequest = PublicKeyRequest()
        
        dispatchGroup.enter()
        serviceManager.networkRequest(for: .getPublicKey, encodingData: publicKeyRequest) { [weak self] (responseData: PublicKeyResponse?, error) in
            guard error == nil else {
                self?.error = error
                dispatchGroup.leave()
                return
            }
            
            guard responseData?.responseCode == "0" else {
                if let code = responseData?.responseCode, let intCode = Int(code), let description = responseData?.responseMessage {
                    self?.error = NSError(domain: "", code: intCode, userInfo: [NSLocalizedDescriptionKey: description])
                }
                dispatchGroup.leave()
                return
            }
            
            self?.publicKey = responseData?.publicKey
            dispatchGroup.leave()
        }
        
        guard let checkOutId = checkOutId else { return }
        let paymentInfoRequest = PaymentInformationRequest(checkOutId: checkOutId)
        var paymentData: PaymentInformationResponse?
        
        dispatchGroup.enter()
        serviceManager.networkRequest(for: .getPaymentInformation, encodingData: paymentInfoRequest) { [weak self] (responseData: PaymentInformationResponse?, error) in
            guard error == nil else {
                self?.error = error
                dispatchGroup.leave()
                return
            }
            
            guard responseData?.responseCode == "0" else {
                if let code = responseData?.responseCode, let intCode = Int(code), let description = responseData?.responseMessage {
                    self?.error = NSError(domain: "", code: intCode, userInfo: [NSLocalizedDescriptionKey: description])
                }
                dispatchGroup.leave()
                return
            }
            
            paymentData = responseData
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard self?.error == nil else {
                self?.loadingIndicator?.stopAnimating()
                self?.delegate?.didFinishPayment(didAbortWithError: (self?.error)!)
                return
            }
            self?.loadingIndicator?.stopAnimating()
            self?.paymentInformation = paymentData
        }
    }
}
