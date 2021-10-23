//
//  BaseNetworkManager.swift
//  HomegateTestAssignmentUIKit
//
//  Created by Vladimir Lukic on 23.10.21..
//

import Foundation

// Define type params
public typealias Parameters = [String:Any]

public protocol ParameterEncoder {
    
    func encode(urlRequest: inout URLRequest, with paramters: Parameters) throws
}

public enum ParameterEncoding {
    
    // Types of possible encoding
    case urlEncoding
    case jsonEncoding
    case urlAndJsonEncoding
    case none
    
    // Handle encode
    public func encode(urlRequest: inout URLRequest, urlParameters: Parameters?, bodyParameters: Parameters?) throws {
        do {
            switch self {
                
            // URL querry param encoding
            case .urlEncoding:
                guard let urlParameters = urlParameters else { return }
                try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
                
            // JSON body params encoding
            case .jsonEncoding:
                guard let bodyParameters = bodyParameters else { return }
                try JSONParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
                
            // Encode both
            case .urlAndJsonEncoding:
                guard let bodyParameters = bodyParameters,
                    let urlParameters = urlParameters else { return }
                try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
                try JSONParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)

            // Do not encode
            case .none:
                break
            }
        
        // Throw encoding error
        } catch {
            throw error
        }
    }
}

