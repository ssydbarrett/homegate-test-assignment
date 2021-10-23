//
//  BaseNetworkManager.swift
//  HomegateTestAssignmentUIKit
//
//  Created by Vladimir Lukic on 23.10.21..
//

import Foundation

public struct URLParameterEncoder: ParameterEncoder {
    
    // Handle URL param encoding for querry params
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        
        // Guard url
        guard let url = URL(string: urlRequest.url?.absoluteString ?? "") else { throw NetworkError.missingURL }
        
        // Get url components
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            
            // Get query items
            urlComponents.queryItems = [URLQueryItem]()
            
            // Encode param by param
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            
            // Compose url back from encoded params
            urlRequest.url = urlComponents.url
        }
        
        // Set Content-Type value for header if not set
//        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
//            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
//        }
    }
}
