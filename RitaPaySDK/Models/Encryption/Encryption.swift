//
//  Encryption.swift
//  RitaPaySDK
//
//  Created by Jihad Mahmoud on 29/03/2021.
//

import Foundation
import CommonCrypto

/// Encryption model to encrypt user data
class Encryption {
    /// Singleton to Access Encryption information
    static let shared = Encryption()
    /**
     Main function to encrypt the password clear text
     - returns:
     Encoded password string
     */
    func getEncryptedPassword(from string: String) -> String {
        guard let data = string.data(using: .utf8), let shaData = sha256(data) else { return "" }
        return hexEncodedString(with: shaData)
    }
    
    /**
     Helper function to encrypt password data with SHA256 encryption
     - returns:
     SHA256 encrypted password data (optional)
     - parameters:
        - data: the password data
     */
    private func sha256(_ data: Data) -> Data? {
        guard let res = NSMutableData(length: Int(CC_SHA256_DIGEST_LENGTH)) else { return nil }
        CC_SHA256((data as NSData).bytes, CC_LONG(data.count), res.mutableBytes.assumingMemoryBound(to: UInt8.self))
        return res as Data
    }
    
    /**
     Helper function to convert password encrypted data to hex string
     - returns:
     Encrypted password SHA256 hex string
     - parameters:
        - data: the SHA256 encrypted password data
        - uppercase: boolean to get data in uppercase with default `false` value indicate returned data will be in lowercase
     */
    private func hexEncodedString(with data: Data, uppercase: Bool = false) -> String {
        return data.map {
            if $0 < 16 {
                return "0" + String($0, radix: 16, uppercase: uppercase)
            } else {
                return String($0, radix: 16, uppercase: uppercase)
            }
        }.joined()
    }
    
    /**
     Function to Encrypt user data using server public key and RSA
     - returns:
     Encrypted base64 RSA encrypted string (optional)
     - parameters:
        - key: the key string received from server
        - userDataString: the user data string need to be encrypted
        - uuid: the uuid that will be used in data encryption
     */
    func encryptUserDataString(with key: String, uuid: String, userDataString: String) -> String? {
        let clearMessage = uuid + userDataString
        return encrypt(string: clearMessage, publicKey: key)
    }
    
    /**
     Helper function to create secure key from key string
     - returns:
     encrypted string using key string and RSA encryption (optional)
     - parameters:
        - string: the string to be encrypted
        - publicKey: the public key string to be used in encryption
     */
    private func encrypt(string: String, publicKey: String?) -> String? {
        guard let publicKey = publicKey else { return nil }

        let keyString = publicKey.replacingOccurrences(of: "-----BEGIN RSA PUBLIC KEY-----\n", with: "").replacingOccurrences(of: "\n-----END RSA PUBLIC KEY-----", with: "")
        guard let data = Data(base64Encoded: keyString) else { return nil }

        var attributes: CFDictionary {
            return [kSecAttrKeyType         : kSecAttrKeyTypeRSA,
                    kSecAttrKeyClass        : kSecAttrKeyClassPublic,
                    kSecAttrKeySizeInBits   : 2048,
                    kSecReturnPersistentRef : true] as CFDictionary
        }

        var error: Unmanaged<CFError>? = nil
        guard let secKey = SecKeyCreateWithData(data as CFData, attributes, &error) else {
            print(error.debugDescription)
            return nil
        }
        return encrypt(string: string, publicKey: secKey)
    }

    /**
     Helper function to encrypt string with RSA and secure key
     - returns:
     encrypted string with secure key (optional)
     - parameters:
        - string: the string to be encrypted
        - publicKey: the secure key that will be used in encryption
     */
    private func encrypt(string: String, publicKey: SecKey) -> String? {
        let buffer = [UInt8](string.utf8)

        var keySize   = SecKeyGetBlockSize(publicKey)
        var keyBuffer = [UInt8](repeating: 0, count: keySize)

        guard SecKeyEncrypt(publicKey, SecPadding.PKCS1, buffer, buffer.count, &keyBuffer, &keySize) == errSecSuccess else { return nil }
        return Data(bytes: keyBuffer, count: keySize).base64EncodedString()
       }
}
