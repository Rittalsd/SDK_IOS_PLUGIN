//
//  PublicKeyRequest.swift
//  RitaPaySDK
//
//  Created by Jihad Mahmoud on 28/03/2021.
//

import Foundation

/// The get public key request parameters
struct PublicKeyRequest: Encodable {
    /// Orgnization user name that will be sent in the request body
    let orgnizationUserName = RitaPayConfiguration.shared.orgnizationUserName
    /// Orgnization encrypted password that will be sent in the request body
    let orgnizationPassword = RitaPayConfiguration.shared.encryptedOrgnizationPassword
    /// Application name that will be sent in the request body
    let applicationName = RitaPayConfiguration.shared.applicationName
    
    /// Coding Keys conforming to Encodable protocol to encode the model to JSON
    enum CodingKeys: String, CodingKey {
        case orgnizationUserName = "orgUsrName"
        case orgnizationPassword = "orgPass"
        case applicationName = "appName"
    }
}
