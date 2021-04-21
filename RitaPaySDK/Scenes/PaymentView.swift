//
//  PaymentView.swift
//  RitaPaySDK
//
//  Created by Jihad Mahmoud on 30/03/2021.
//

import Foundation
import UIKit

/// Payment main view
class PaymentView: UIView {
    /// Payment information response returned from service
    var paymentInformation: PaymentInformationResponse? {
        didSet {
            createSubviews()
        }
    }
    /// A closure to be executed on pay button tap (pan, ipin, expiry)
    var textFieldsDidFinishedEntered: ((String, String, String) -> Void)?
    /// Card number text field
    let cardNumberTextField = UITextField()
    /// Card expiry date text field
    let expiryDateTextField = UITextField()
    /// iPIN text field
    let iPinTextField = UITextField()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = .white
    }
    
    /**
     Main method to create the subviews of the payment view
     */
    func createSubviews() {
        let logoImageView = UIImageView()
        let logoImage = UIImage(named: "Logo", in: Bundle(for: type(of: self)), compatibleWith: nil)
        logoImageView.image = logoImage
        logoImageView.contentMode = .scaleAspectFit
        self.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 20).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        let logoHeightContraints = NSLayoutConstraint(item: logoImageView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 80)
        NSLayoutConstraint.activate([logoHeightContraints])
        
        if let companyLogoImage = ThemeManager.shared.companyLogoImage {
            let companyLogoImageView = UIImageView(frame: CGRect(x: 20, y: 20, width: 80, height: 80))
            companyLogoImageView.image = companyLogoImage
            companyLogoImageView.contentMode = .scaleAspectFit
            self.addSubview(companyLogoImageView)
        }
        
        let leftStackView = UIStackView()
        leftStackView.translatesAutoresizingMaskIntoConstraints = false
        leftStackView.spacing = 16
        self.addSubview(leftStackView)
        leftStackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20).isActive = true
        leftStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        leftStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        leftStackView.axis = .vertical
        
        let rightStackView = UIStackView()
        rightStackView.translatesAutoresizingMaskIntoConstraints = false
        rightStackView.spacing = 16
        self.addSubview(rightStackView)
        rightStackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20).isActive = true
        rightStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        rightStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        rightStackView.axis = .vertical
        
        let dateTimeTitleLabel = UILabel()
        dateTimeTitleLabel.text = NSLocalizedString("Date.Time.Title", bundle: Bundle(for: type(of: self)), comment: "The date and time title text")
        leftStackView.addArrangedSubview(dateTimeTitleLabel)
        let dateTimeLabel = UILabel()
        dateTimeLabel.text = paymentInformation?.dateTimeString
        rightStackView.addArrangedSubview(dateTimeLabel)
        
        let referenceIdTitleLabel = UILabel()
        referenceIdTitleLabel.text = NSLocalizedString("Reference.Id.Title", bundle: Bundle(for: type(of: self)), comment: "The reference id title text")
        leftStackView.addArrangedSubview(referenceIdTitleLabel)
        let referenceIdLabel = UILabel()
        referenceIdLabel.text = paymentInformation?.refrenceId
        rightStackView.addArrangedSubview(referenceIdLabel)
        
        let amountTitleLabel = UILabel()
        amountTitleLabel.text = NSLocalizedString("Amount.Title", bundle: Bundle(for: type(of: self)), comment: "The amount title")
        leftStackView.addArrangedSubview(amountTitleLabel)
        let amountLabel = UILabel()
        amountLabel.text = paymentInformation?.amountDecimal?.description
        rightStackView.addArrangedSubview(amountLabel)
        
        let currencyTitleLabel = UILabel()
        currencyTitleLabel.text = NSLocalizedString("Currency.Title", bundle: Bundle(for: type(of: self)), comment: "The currency title text")
        leftStackView.addArrangedSubview(currencyTitleLabel)
        let currencyLabel = UILabel()
        currencyLabel.text = paymentInformation?.currecny
        rightStackView.addArrangedSubview(currencyLabel)
        
        let serviceTitleLabel = UILabel()
        serviceTitleLabel.text = NSLocalizedString("Service.Title", bundle: Bundle(for: type(of: self)), comment: "The currency title text")
        leftStackView.addArrangedSubview(serviceTitleLabel)
        let serviceLabel = UILabel()
        serviceLabel.text = paymentInformation?.serviceName
        rightStackView.addArrangedSubview(serviceLabel)
        
        let customerNameTitleLabel = UILabel()
        customerNameTitleLabel.text = NSLocalizedString("Customer.Name.Title", bundle: Bundle(for: type(of: self)), comment: "The customer name title text")
        leftStackView.addArrangedSubview(customerNameTitleLabel)
        let customerNameLabel = UILabel()
        customerNameLabel.text = paymentInformation?.customerName
        rightStackView.addArrangedSubview(customerNameLabel)
        
        let customerPhoneNumberTitleLabel = UILabel()
        customerPhoneNumberTitleLabel.text = NSLocalizedString("Customer.Phone.Number.Title", bundle: Bundle(for: type(of: self)), comment: "The customer phone number title text")
        leftStackView.addArrangedSubview(customerPhoneNumberTitleLabel)
        let customerPhoneNumberLabel = UILabel()
        customerPhoneNumberLabel.text = paymentInformation?.customerPhoneNumber
        rightStackView.addArrangedSubview(customerPhoneNumberLabel)
        
        let cardNumberTitleLabel = UILabel()
        cardNumberTitleLabel.text = NSLocalizedString("Card.Number.Title", bundle: Bundle(for: type(of: self)), comment: "The card number (pan) title text")
        leftStackView.addArrangedSubview(cardNumberTitleLabel)
        cardNumberTextField.placeholder = NSLocalizedString("Card.Number.Placeholder", bundle: Bundle(for: type(of: self)), comment: "The card number (pan) placeholder text")
        cardNumberTextField.keyboardType = .numberPad
        cardNumberTextField.borderStyle = .roundedRect
        rightStackView.addArrangedSubview(cardNumberTextField)
        cardNumberTitleLabel.heightAnchor.constraint(equalTo: cardNumberTextField.heightAnchor).isActive = true
        
        let expiryDateTitleLabel = UILabel()
        expiryDateTitleLabel.text = NSLocalizedString("Expiry.Date.Title", bundle: Bundle(for: type(of: self)), comment: "The card expiry date title text")
        leftStackView.addArrangedSubview(expiryDateTitleLabel)
        expiryDateTextField.delegate = self
        expiryDateTextField.placeholder = NSLocalizedString("Expiry.Date.Placeholder", bundle: Bundle(for: type(of: self)), comment: "The card expiry date placeholder")
        expiryDateTextField.keyboardType = .numberPad
        expiryDateTextField.borderStyle = .roundedRect
        rightStackView.addArrangedSubview(expiryDateTextField)
        expiryDateTitleLabel.heightAnchor.constraint(equalTo: expiryDateTextField.heightAnchor).isActive = true
        
        let iPinTitleLabel = UILabel()
        iPinTitleLabel.text = NSLocalizedString("IPin.Title", bundle: Bundle(for: type(of: self)), comment: "The internet pin title text")
        leftStackView.addArrangedSubview(iPinTitleLabel)
        iPinTextField.placeholder = NSLocalizedString("IPin.Placeholder", bundle: Bundle(for: type(of: self)), comment: "The internet pin placeholder")
        iPinTextField.keyboardType = .numberPad
        iPinTextField.borderStyle = .roundedRect
        iPinTextField.isSecureTextEntry = true
        rightStackView.addArrangedSubview(iPinTextField)
        iPinTitleLabel.heightAnchor.constraint(equalTo: iPinTextField.heightAnchor).isActive = true
        
        let payButton = UIButton()
        payButton.backgroundColor = ThemeManager.shared.themeColor
        payButton.setTitleColor(.white, for: .normal)
        let payButtonTitle = NSLocalizedString("Pay.Button.Title", bundle: Bundle(for: type(of: self)), comment: "The pay button title text")
        payButton.setTitle(payButtonTitle, for: .normal)
        payButton.addTarget(self, action: #selector(payButtonTappedInside(_:)), for: .touchUpInside)
        payButton.layer.cornerRadius = 10
        self.addSubview(payButton)
        payButton.translatesAutoresizingMaskIntoConstraints = false
        payButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        payButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 100).isActive = true
        payButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -100).isActive = true
        let heightContraints = NSLayoutConstraint(item: payButton, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 40)
        NSLayoutConstraint.activate([heightContraints])
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func payButtonTappedInside(_ sender: UIButton) {
        textFieldsDidFinishedEntered?(cardNumberTextField.text!, iPinTextField.text!, expiryDateTextField.text!)
    }
    
    @objc func hideKeyboard() {
        self.endEditing(true)
    }
}

extension PaymentView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = textField.text, let r = Range(range, in: oldText) else {
            return true
        }
        let updatedText = oldText.replacingCharacters(in: r, with: string)
        
        if string == "" {
            if updatedText.count == 2 {
                textField.text = "\(updatedText.prefix(1))"
                return false
            }
        } else if updatedText.count > 4 {
            return false
        }
        
        return true
    }
}
