//
//  PaymentResponse.swift
//  RitaPaySDK
//
//  Created by Jihad Mahmoud on 29/03/2021.
//

import Foundation

/// The payment response model
public struct PaymentResponse: Decodable {
    /// Response code
    public let responseCode: String
    /// Response Status
    public let responseStatus: String
    /// Response message
    public let responseMessage: String
    /// check out id (uuid)
    public let checkOutId: String?
    /// Payment status
    public let paymentStatus: String?
    /// Card number
    public let pan: String?
    /// Card available balance string
    let balance: String?
    /// Card available balance floating point
    public var balanceDecimal: Double? {
        guard let balanceInDouble = Double(balance ?? "") else {
            return nil
        }
        return balanceInDouble
    }
    /// Card expiry date
    public let expiryDate: String?
    /// Reference Id
    public let referenceId: String?
    /// Request date time in format ddMMyyHHmmss
    public let requestDateTime: String?
    /// Transaction currency
    public let currency: String?
    /// Customer name
    public let customerName: String?
    /// Customer Phone Number
    public let customerPhoneNumber: String?
    /// Transaction amount string
    let transactionAmount: String?
    /// Transaction amount floating point
    public var transactionAmountDecimal: Double? {
        guard let amountInDouble = Double(transactionAmount ?? "") else {
            return nil
        }
        return amountInDouble
    }
    /// Transaction date and time in format ddMMyyHHmmss
    public let transactionDateTime: String?
    
    /// Coding Keys conforming to Decodable protocol to decode JSON into model
    enum CodingKeys: String, CodingKey {
        case responseCode = "responseCode"
        case responseStatus = "responseStatus"
        case responseMessage = "responseMessage"
        case checkOutId = "checkOutID"
        case paymentStatus = "PaymentStatus"
        case pan = "PAN"
        case balance = "Balance"
        case expiryDate = "expDate"
        case referenceId = "refrenceID"
        case requestDateTime = "DateTimeRequest"
        case currency
        case customerName = "custName"
        case customerPhoneNumber = "custPhone"
        case transactionAmount = "tranAmount"
        case transactionDateTime = "tranDateTime"
    }
}
