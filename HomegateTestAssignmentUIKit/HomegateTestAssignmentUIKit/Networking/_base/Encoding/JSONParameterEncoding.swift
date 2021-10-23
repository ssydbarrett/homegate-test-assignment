//
//  BaseNetworkManager.swift
//  HomegateTestAssignmentUIKit
//
//  Created by Vladimir Lukic on 23.10.21..
//

import Foundation

public struct JSONParameterEncoder: ParameterEncoder {
        
    // Handle JSON param encoding for body
    public func encode(urlRequest: inout URLRequest, with paramters: Parameters) throws {
        do {
            
            // Add encoded params to body
            let jsonAsData = try JSONSerialization.data(withJSONObject: paramters, options: .withoutEscapingSlashes)
            urlRequest.httpBody = jsonAsData
            
            // Set Content-Type value for header if not set
//            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
//                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            }
            
        // Catch error
        } catch {
            throw NetworkError.encodingFailed
        }
    }
}
