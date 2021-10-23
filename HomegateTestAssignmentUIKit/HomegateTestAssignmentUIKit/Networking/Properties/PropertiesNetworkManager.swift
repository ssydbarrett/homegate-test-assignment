//
//  PropertiesNetworkManager.swift
//  HomegateTestAssignmentUIKit
//
//  Created by Vladimir Lukic on 23.10.21..
//

import UIKit

class PropertiesNetworkManager: BaseNetworkManager {

    // Get all moccup properties
    class func getProperties(completionHandler: @escaping CompletionHandler) {
        
        // Configure URL params
        
        // Configure body params
        
        // Configure headers
        var headers = [String: String]()
        headers[ConstantsAPI.headerParamContent] = ConstantsAPI.headerValueContentJSON
        
        // Execute API call
        executeGET(
            service: ConstantsAPI.serviceProperties,
            urlParams: nil,
            body: nil,
            header: headers)
        { (result, status, error) in
            
            // Return completion closure
            completionHandler(result, status, error)
        }
    }
}
