//
//  PaymentInformationResponse.swift
//  RitaPaySDK
//
//  Created by Jihad Mahmoud on 28/03/2021.
//

import Foundation

/// The get payment information response model
public struct PaymentInformationResponse: Decodable {
    /// Response code
    let responseCode: String
    /// Response Status
    let responseStatus: String
    /// Response message
    let responseMessage: String
    /// check out id (uuid)
    let checkOutId: String?
    /// Payment status
    let paymentStatus: String?
    /// Transaction Amount string
    let amount: String?
    /// Transaction currency
    let currecny: String?
    /// Customer name
    let customerName: String?
    /// Customer phone number
    let customerPhoneNumber: String?
    /// Transaction date and time in seconds (time interval since 1970)
    let dateTime: String?
    /// Response language
    let language: String?
    /// Redirection URL
    let returnedUrl: String?
    /// Reference Id
    let refrenceId: String?
    /// Application name (service)
    let serviceName: String?
    /// Date and time string
    var dateTimeString: String? {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "ddMMyyHHmmss"
        let dateForamtterReturn = DateFormatter()
        dateForamtterReturn.dateFormat = "dd/MM/yyyy HH:mm:ss"
        guard let dateTimeGet = dateTime, let date = dateFormatterGet.date(from: dateTimeGet)  else {
            return nil
        }
        return dateForamtterReturn.string(from: date)
    }
    /// Amount in floating point
    var amountDecimal: Double? {
        guard let amountInDecimal = Double(amount ?? "") else {
            return nil
        }
        return amountInDecimal
    }
    
    /// Coding Keys conforming to Decodable protocol to decode JSON into model
    enum CodingKeys: String, CodingKey {
        case responseCode = "ResponseCode"
        case responseStatus = "ResponseStatus"
        case responseMessage = "ResponseMessage"
        case checkOutId = "checkOutID"
        case paymentStatus = "PaymentStatus"
        case amount = "amount"
        case currecny = "currency"
        case customerName = "custName"
        case customerPhoneNumber = "custPhone"
        case dateTime = "dateTime"
        case language = "language"
        case returnedUrl = "returnedURL"
        case refrenceId = "refrenceID"
        case serviceName = "appName"
    }
}
