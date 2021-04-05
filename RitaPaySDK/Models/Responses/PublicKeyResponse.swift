//
//  PublicKeyResponse.swift
//  RitaPaySDK
//
//  Created by Jihad Mahmoud on 28/03/2021.
//

import Foundation

/// The get public key response model
struct PublicKeyResponse: Decodable {
    /// Response code
    let responseCode: String
    /// Response status
    let responseStatus: String
    /// Response message
    let responseMessage: String
    /// Public key string to use to encode private user data
    let publicKey: String?
    
    /// Coding Keys conforming to Decodable protocol to decode JSON into model
    enum CodingKeys: String, CodingKey {
        case publicKey = "pubKeyValue"
        case responseCode 
        case responseStatus
        case responseMessage
    }
}
