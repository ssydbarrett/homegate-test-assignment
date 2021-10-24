//
//  BaseModel.swift
//  HomegateTestAssignmentUIKit
//
//  Created by Vladimir Lukic on 24.10.21..
//

import UIKit

class BaseModel: Codable, Hashable {

    // MARK:- Properties
    
    // Meta
    var id: Int? = -1
    var timestamp: Int? = 0
    var timestampStr: String? = ""
    var lastModified: Int? = 0
    var searchInquiryTimestamp: Int? = 0
    
    // MARK:- Constructors
    
    init() { }
    
    init(id: Int, timestamp: Int = 0) {
        self.id = id
        self.timestamp = timestamp
    }
    
    // Decoding
    required init (from decoder: Decoder) throws {
        // try super.init(from: decoder)
        
        // Add specification for model
        let container =  try decoder.container (keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent (Int.self, forKey: .id)
        timestamp = try container.decodeIfPresent (Int.self, forKey: .timestamp)
        timestampStr = try container.decodeIfPresent (String.self, forKey: .timestampStr)
        lastModified = try container.decodeIfPresent (Int.self, forKey: .lastModified)
        searchInquiryTimestamp = try container.decodeIfPresent (Int.self, forKey: .searchInquiryTimestamp)
    }
    
    // Encoding
    func encode (to encoder: Encoder) throws {
        // try super.encode(to: encoder)
        
        // Add specification for model
        var container = encoder.container (keyedBy: CodingKeys.self)
        try container.encodeIfPresent (id, forKey: .id)
        try container.encodeIfPresent (timestamp, forKey: .timestamp)
        try container.encodeIfPresent (timestampStr, forKey: .timestampStr)
        try container.encodeIfPresent (lastModified, forKey: .lastModified)
        try container.encodeIfPresent (searchInquiryTimestamp, forKey: .searchInquiryTimestamp)
    }
    
    // Hashable
    func hash(into hasher: inout Hasher) {
        // super.hash(into: &hasher)
        
        // Hash specification for model
        hasher.combine(id)
        hasher.combine(timestamp)
        hasher.combine(timestampStr)
        hasher.combine(lastModified)
        hasher.combine(searchInquiryTimestamp)
    }
    
    // Equaleablility :D
    static func == (lhs: BaseModel, rhs: BaseModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    // CodingKeys for properties
    enum CodingKeys: String, CodingKey {
        
        // Meta
        case id = "id"
        case timestamp = "timestamp"
        case timestampStr = "timestampStr"
        case lastModified = "lastModified"
        case searchInquiryTimestamp = "searchInquiryTimestamp"
    }
}

