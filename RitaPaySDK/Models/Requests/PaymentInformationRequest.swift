//
//  PaymentInformationRequest.swift
//  RitaPaySDK
//
//  Created by Jihad Mahmoud on 28/03/2021.
//

import Foundation

/// The get payment information request parameters
struct PaymentInformationRequest: Encodable {
    /// Orgnization user name that will be sent in the request body
    let orgnizationUserName = RitaPayConfiguration.shared.orgnizationUserName
    /// Orgnization encrypted password that will be sent in the request body
    let orgnizationPassword = RitaPayConfiguration.shared.encryptedOrgnizationPassword
    /// Application name that will be sent in the request body
    let applicationName = RitaPayConfiguration.shared.applicationName
    /// check out id that will be sent in the request body
    let checkOutId: String
    
    /// Coding Keys conforming to Encodable protocol to encode the model to JSON
    enum CodingKeys: String, CodingKey {
        case orgnizationUserName = "orgUsrName"
        case orgnizationPassword = "orgPass"
        case applicationName = "appName"
        case checkOutId = "CheckOutID"
    }
}
