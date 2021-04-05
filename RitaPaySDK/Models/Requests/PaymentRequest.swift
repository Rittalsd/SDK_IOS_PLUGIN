//
//  PaymentRequest.swift
//  RitaPaySDK
//
//  Created by Jihad Mahmoud on 29/03/2021.
//

import Foundation

/// the payment request parameters
struct PaymentRequest: Encodable {
    /// Orgnization user name that will be sent in the request body
    let orgnizationUserName = RitaPayConfiguration.shared.orgnizationUserName
    /// Orgnization encrypted password that will be sent in the request body
    let orgnizationPassword = RitaPayConfiguration.shared.encryptedOrgnizationPassword
    /// Application name that will be sent in the request body
    let applicationName = RitaPayConfiguration.shared.applicationName
    /// check out id that will be sent in the request body
    let checkOutId: String
    /// Card number that will be sent in the request body
    let pan: String
    /// Card expiry date that will be sent in the request body
    let expiryDate: String
    /// Encrypted card internet personal identification number that will be sent in the request body
    let iPin: String
    
    /// Coding Keys conforming to Encodable protocol to encode the model to JSON
    enum CodingKeys: String, CodingKey {
        case orgnizationUserName = "orgUsrName"
        case orgnizationPassword = "orgPass"
        case applicationName = "appName"
        case checkOutId = "checkOutID"
        case pan = "PAN"
        case expiryDate = "expDate"
        case iPin = "IPIN"
    }
}
