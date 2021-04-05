//
//  PaymentViewDelegate.swift
//  RitaPaySDK
//
//  Created by Jihad Mahmoud on 29/03/2021.
//

import Foundation

/// Payment view delegate protocol
public protocol PaymentViewDelegate: AnyObject {
    /**
     Delegate method called upon successful payment operation
     - parameters:
        - payment: the payment response object to be handled in the host application
     */
    func didFinishPayment(_ payment: PaymentResponse?)
    /**
     Delegate method called upon payment failure
     - parameters:
        - error: the error object to be handled in the host application
     */
    func didFinishPayment(didAbortWithError error: Error)
}
