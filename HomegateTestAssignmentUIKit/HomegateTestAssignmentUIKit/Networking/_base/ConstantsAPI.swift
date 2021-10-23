//
//  ConstantsAPI.swift
//  HomegateTestAssignmentUIKit
//
//  Created by Vladimir Lukic on 23.10.21..
//

import UIKit

// Configure type for completion handler of API calls
typealias CompletionHandler = (_ result: String?, _ status: Int?, _ error: NetworkError?) -> Void

// API constants
struct ConstantsAPI {
    
    // *** Base url ***
    
    static let baseURLFromPdf               = "http://private-492e5-homegate1.apiary-mock.com"
    static let baseURLFromSite              = "https://private-anon-566c77ccff-homegate1.apiary-mock.com"
    
    // Services
    static let serviceProperties            = "/properties"
    
    // Header constants - params
    static let headerParamContent           = "Content-Type"
    static let headerParamPlatform          = "platform"
    static let headerParamDevice            = "device"
    
    // Header constants - values
    static let headerValueContentJSON       = "application/json"
    static let headerValuePlatform          = "ios"
}

// Http methods
public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

// Enum of networking errors
public enum NetworkError : String, Error {

    // No params to encode
    case parametersNil = "Parameters were nil."
    
    // Encoding failed
    case encodingFailed = "Parameter encoding failed."
    
    // Request build failed
    case requestFailed = "Request build failed."
    
    // No url provided
    case missingURL = "URL is nil."
    
    // No internet connection
    case noInternetConnection = "No internet connection."
    
    // Bad response
    case badResponse = "Bad response."
    
    // No response data available
    case noResponseData = "No response data."
    
    // Response error
    case responseError = "Response error."
    
}
