//
//  Configuration.swift
//  RitaPaySDK
//
//  Created by Jihad Mahmoud on 28/03/2021.
//

import Foundation

/// The SDK configuration
public class RitaPayConfiguration {
    /// Singleton to Access Configuration information
    public static let shared = RitaPayConfiguration()
    
    /// Application protocol
    public var appProtocol: String = ""
    /// Application domain
    public var appDomain: String = ""
    /// Application prot
    public var appPort: String = ""
    /// Application url string
    var urlString: String {
        return "\(appProtocol)://\(appDomain):\(appPort)/api/"
    }
    /// Application Name that will be used for the SDK
    public var applicationName = ""
    /// Orgnization Name that will be used for the SDK
    public var orgnizationUserName = ""
    /// Orgnization clear password that will be encrypted and used for the SDK
    public var orgnizationPassword = ""
    /// Orgnization encrypted password
    var encryptedOrgnizationPassword: String {
        return Encryption.shared.getEncryptedPassword(from: orgnizationPassword)
    }
}
