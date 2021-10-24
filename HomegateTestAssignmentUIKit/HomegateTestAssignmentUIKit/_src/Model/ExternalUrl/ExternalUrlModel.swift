//
//  ExternalUrlModel.swift
//  HomegateTestAssignmentUIKit
//
//  Created by Vladimir Lukic on 24.10.21..
//

import UIKit

// Url types as enum
public enum ExternalUrl : String {
    case document = "DOCUMENT"
    case tour = "VIRTUAL_TOUR"
}

class ExternalUrlModel: BaseModel {

    // MARK:- Properties
    
    // Info
    var url: String? = ""
    var type: String? = ""
    var label: String? = ""
    
    // MARK:- Constructors
    
    override init() {
        super.init()
    }
    
    // Decoding
    required init (from decoder: Decoder) throws {
        try super.init(from: decoder)
        
        let container =  try decoder.container (keyedBy: CodingKeys.self)
        url = try container.decodeIfPresent (String.self, forKey: .url)
        type = try container.decodeIfPresent (String.self, forKey: .type)
        label = try container.decodeIfPresent (String.self, forKey: .label)
    }
    
    // Encoding
    override func encode (to encoder: Encoder) throws {
        try super.encode(to: encoder)
        
        // Add specification for model
        var container = encoder.container (keyedBy: CodingKeys.self)
        try container.encodeIfPresent (url, forKey: .url)
        try container.encodeIfPresent (type, forKey: .type)
        try container.encodeIfPresent (label, forKey: .label)
    }
    
    // Hashable
    override func hash(into hasher: inout Hasher) {
        super.hash(into: &hasher)
        
        // Hash specification for model
        hasher.combine(url)
        hasher.combine(type)
        hasher.combine(label)
    }
    
    // Equaleablility :D
    static func == (lhs: ExternalUrlModel, rhs: ExternalUrlModel) -> Bool {
        return lhs.url == rhs.url
    }
    
    // CodingKeys for properties
    enum CodingKeys: String, CodingKey {
        
        // Info
        case url = "url"
        case type = "type"
        case label = "label"
    }
}

