//
//  Router.swift
//  RitaPaySDK
//
//  Created by Jihad Mahmoud on 29/03/2021.
//

import Foundation

/// Requestable protocol to define services
protocol Requestable {
    var method: HTTPMEthod { get }
    var urlString: String? { get }
    var timeIntervalForRequest: TimeInterval { get }
    var encoding: EncodingType { get }
    var additionalHeaders: [String: String]? { get }
}

extension Requestable {
    var method: HTTPMEthod {
        return .post
    }
    
    var urlString: String? {
        return nil
    }
     
    var timeIntervalForRequest: TimeInterval {
        return 300.0
    }
    
    var encoding: EncodingType {
        return .json
    }
    
    var additionalHeaders: [String: String]? {
        return nil
    }
}


typealias Parameters = [String: Any]

enum HTTPMEthod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum EncodingType: String {
    case json = "application/json"
}
