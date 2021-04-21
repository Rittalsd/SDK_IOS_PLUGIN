//
//  ServiceManager.swift
//  RitaPaySDK
//
//  Created by Jihad Mahmoud on 29/03/2021.
//

import Foundation

/// Service manager to handle network calls
class ServiceManager: Requestable {
    /// Singelton to access service manager
    static let shared = ServiceManager()
    
    /// Router enum with all requests
    enum Router: Requestable {
        case getPublicKey
        case getPaymentInformation
        case doPayment
        
        var urlString: String? {
            switch self {
            case .getPublicKey: return "\(RitaPayConfiguration.shared.urlString)getPublicKey"
            case .getPaymentInformation: return "\(RitaPayConfiguration.shared.urlString)getPaymentInfo"
            case .doPayment: return "\(RitaPayConfiguration.shared.urlString)doPayment"
            }
        }
    }
    
    /**
     Main function to do network services' requests
     - parameters:
        - router: the router case which is the service being called
        - encodingData: the request parameters encodable model
        - completion: escaping completion block to be executed when the service call ends which return decodable model or error
     */
    func networkRequest<T: Decodable, Q: Encodable>(for router: Router, encodingData: Q, completion: @escaping ((T?, Error?) -> ())) {
        guard let url = URL(string: router.urlString ?? "") else {
            DispatchQueue.main.async {
                completion(nil, RitalError.urlError)
            }
            return
        }
        
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = router.timeIntervalForRequest
        config.timeoutIntervalForResource = router.timeIntervalForRequest
        config.httpAdditionalHeaders = ["Content-Type": router.encoding.rawValue]
        
        let session = URLSession(configuration: config)
        var request = URLRequest(url: url)
        request.httpMethod = router.method.rawValue
        
        do {
            let jsonBody = try JSONEncoder().encode(encodingData)
            request.httpBody = jsonBody
        } catch (let error) {
            DispatchQueue.main.async {
                completion(nil, error)
            }
        }
        
        let task = session.dataTask(with: request) { [weak self] (data, response, error) in
            self?.log(request: request)
            self?.log(data: data, response: response as? HTTPURLResponse, error: error)
            guard error == nil else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, RitalError.noDataFound)
                }
                return
            }
            
            do {
                let responseData = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(responseData, nil)
                }
            } catch (let error) {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
    func log(request: URLRequest){

        let urlString = request.url?.absoluteString ?? ""
        let components = NSURLComponents(string: urlString)

        let method = request.httpMethod != nil ? "\(request.httpMethod!)": ""
        let path = "\(components?.path ?? "")"
        let query = "\(components?.query ?? "")"
        let host = "\(components?.host ?? "")"

        var requestLog = "\n---------- OUT ---------->\n"
        requestLog += "\(urlString)"
        requestLog += "\n\n"
        requestLog += "\(method) \(path)?\(query) HTTP/1.1\n"
        requestLog += "Host: \(host)\n"
        for (key,value) in request.allHTTPHeaderFields ?? [:] {
            requestLog += "\(key): \(value)\n"
        }
        if let body = request.httpBody{
            let bodyString = NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "Can't render body; not utf8 encoded";
            requestLog += "\n\(bodyString)\n"
        }

        requestLog += "\n------------------------->\n";
        print(requestLog)
    }

    func log(data: Data?, response: HTTPURLResponse?, error: Error?){

        let urlString = response?.url?.absoluteString
        let components = NSURLComponents(string: urlString ?? "")

        let path = "\(components?.path ?? "")"
        let query = "\(components?.query ?? "")"

        var responseLog = "\n<---------- IN ----------\n"
        if let urlString = urlString {
            responseLog += "\(urlString)"
            responseLog += "\n\n"
        }

        if let statusCode =  response?.statusCode{
            responseLog += "HTTP \(statusCode) \(path)?\(query)\n"
        }
        if let host = components?.host{
            responseLog += "Host: \(host)\n"
        }
        for (key,value) in response?.allHeaderFields ?? [:] {
            responseLog += "\(key): \(value)\n"
        }
        if let body = data{
            let bodyString = NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "Can't render body; not utf8 encoded";
            responseLog += "\n\(bodyString)\n"
        }
        if let error = error{
            responseLog += "\nError: \(error.localizedDescription)\n"
        }

        responseLog += "<------------------------\n";
        print(responseLog)
    }
}
