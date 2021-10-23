//
//  BaseNetworkManager.swift
//  HomegateTestAssignmentUIKit
//
//  Created by Vladimir Lukic on 23.10.21..
//

import Foundation
import UIKit
import SystemConfiguration

class BaseNetworkManager: NSObject {
    
    // MARK: - Properties
    // MARK:
    
    // MARK: - API Calls
    // MARK:
    
    // Execute API calls based on method
    class func executeGET (
        service: String?,
        urlParams: [String : Any]?,
        body: [String : Any]?,
        header: [String : String]?,
        completion: @escaping CompletionHandler) {
            execute(method: .get, service: service, urlParams: urlParams, body: body, header: header, paramEncoding: ParameterEncoding.urlEncoding, completion: completion)
        }
    class func executePOST (
        service: String?,
        urlParams: [String : Any]?,
        body: [String : Any]?,
        header: [String : String]?,
        completion: @escaping CompletionHandler) {
            execute(method: .post, service: service, urlParams: urlParams, body: body, header: header, paramEncoding: ParameterEncoding.jsonEncoding, completion: completion)
        }
    
    ///
    /// Execute default base API call
    ///
    
    class func execute(
        method: HTTPMethod,
        service: String?,
        urlParams: [String : Any]?,
        body: [String : Any]?,
        header: [String : String]?,
        paramEncoding: ParameterEncoding,
        completion: @escaping CompletionHandler) {
            
            // Check for internet connection
            if !isConnectedToNetwork() {
                completion(nil, nil, .noInternetConnection)
                return
            }
            
            // Create URL
            let urlString = String(format: "%@%@%@",
                                   ConstantsAPI.baseURLFromPdf,
                                   service == nil ? "" : service!,
                                   urlParams == nil ? "" : urlParams!)
            guard let url = URL(string: urlString) else { completion(nil, nil, .missingURL); return }
            
            // Build request based on params
            var request = URLRequest(url: url)
            do {
                request = try buildRequest(from: url, with: paramEncoding, httpMethod: method, urlParams: urlParams, bodyParameters: body, and: header)
            }
            catch {
                completion(nil, nil, .requestFailed)
                return
            }
            
            // Configure session
            let session = URLSession.shared
            session.configure()
            
            // Start url session task
            let task = session.dataTask(with: request) { data, response, error in
                
                // Get status code
                var status = 0
                if let urlResponse = response as? HTTPURLResponse {
                    status = urlResponse.statusCode
                }
                
                // Handle error
                if error != nil {
                    print(error ?? "Unknown error")
                    completion(nil, status, .responseError)
                    return
                }
                
                // Get response
                if let response = response {
                    print(response)
                    
                    // Get JSON response as string, and complete request successfully
                    if let data = data, let body = String(data: data, encoding: .utf8) {
                        print(body)
                        completion(body, status, nil)
                        return
                    } else {
                        
                        // Handle bad data
                        completion(nil, status, .noResponseData)
                        return
                    }
                } else {
                    
                    // Handle bad response
                    print(error ?? "Unknown error")
                    completion(nil, status, .badResponse)
                    return
                }
            }
            
            // Resume task
            task.resume()
        }
    
    ///
    /// Build rquest for endpoint and configure HTTPTask parameters with body parameters/encoding or url paramteres/encoding with headers
    ///
    
    class func buildRequest(from url: URL, with encoding: ParameterEncoding, httpMethod: HTTPMethod, urlParams: Parameters?, bodyParameters: Parameters?, and headers: [String: String]?) throws -> URLRequest {
        
        // Create request
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 20.0)
        request.httpMethod = httpMethod.rawValue
        
        // Add headers
        BaseNetworkManager.configureHeader(headerOrg: headers, for: &request)
        
        // Encode params
        do {
            try encoding.encode(urlRequest: &request, urlParameters: urlParams, bodyParameters: bodyParameters)
            return request
        } catch {
            throw error
        }
    }
}

// MARK: - Extension for header configuration
// MARK:

extension BaseNetworkManager {
    
    // Configure header
    class func configureHeader(headerOrg: [String : String]?, for request: inout URLRequest) {
        
        // Create default header
        var header = [String : String]()
        
        // Add existing header
        if headerOrg != nil {
            header = headerOrg!
        }
        
        // Add platform and device to all requests
        header[ConstantsAPI.headerParamPlatform] = ConstantsAPI.headerValuePlatform
        header[ConstantsAPI.headerParamDevice] = UIDevice.modelName
        
        // Add headers to request
        for (headerField, headerValue) in header {
            request.setValue(headerValue, forHTTPHeaderField: headerField)
        }
    }
}

// MARK: - Extension for checking reachability
// MARK:

extension BaseNetworkManager {
    
    // Check internet connection
    static func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags.connectionAutomatic
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
}

// MARK: - Extension for session configuration
// MARK:

extension URLSession {
    func configure(_ timeoutInterval: TimeInterval = 20) {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeoutInterval
        configuration.timeoutIntervalForResource = timeoutInterval
        if #available(iOS 11, *) {
            configuration.waitsForConnectivity = true
        }
    }
}
