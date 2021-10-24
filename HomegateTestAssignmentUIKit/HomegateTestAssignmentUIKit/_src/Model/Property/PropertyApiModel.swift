//
//  PropertyApiModel.swift
//  HomegateTestAssignmentUIKit
//
//  Created by Vladimir Lukic on 24.10.21..
//

import UIKit

class PropertyApiModel: BaseModel { // or it could be BaseApiListModel with generic class for items
    
    // MARK:- Properties
    
    // Paging
    var resultCount: Int? = 0
    var start: Int? = 0
    var page: Int? = 0
    var pageCount: Int? = 0
    var itemsPerPage: Int? = 0
    var hasNextPage: Bool? = false
    var hasPreviousPage: Bool? = false

    // Items
    var items: [PropertyModel]? = [PropertyModel]()
    
    // MARK:- Constructors
    
    override init() {
        super.init()
    }
    
    // Decoding
    required init (from decoder: Decoder) throws {
        try super.init(from: decoder)
        
        let container =  try decoder.container (keyedBy: CodingKeys.self)
        resultCount = try container.decodeIfPresent (Int.self, forKey: .resultCount)
        start = try container.decodeIfPresent (Int.self, forKey: .start)
        page = try container.decodeIfPresent (Int.self, forKey: .page)
        pageCount = try container.decodeIfPresent (Int.self, forKey: .pageCount)
        itemsPerPage = try container.decodeIfPresent (Int.self, forKey: .itemsPerPage)
        hasNextPage = try container.decodeIfPresent (Bool.self, forKey: .hasNextPage)
        hasPreviousPage = try container.decodeIfPresent (Bool.self, forKey: .hasPreviousPage)
        items = try container.decodeIfPresent ([PropertyModel].self, forKey: .items)
    }
    
    // Encoding
    override func encode (to encoder: Encoder) throws {
        try super.encode(to: encoder)
        
        // Add specification for model
        var container = encoder.container (keyedBy: CodingKeys.self)
        try container.encodeIfPresent (resultCount, forKey: .resultCount)
        try container.encodeIfPresent (start, forKey: .start)
        try container.encodeIfPresent (page, forKey: .page)
        try container.encodeIfPresent (pageCount, forKey: .pageCount)
        try container.encodeIfPresent (itemsPerPage, forKey: .itemsPerPage)
        try container.encodeIfPresent (hasNextPage, forKey: .hasNextPage)
        try container.encodeIfPresent (hasPreviousPage, forKey: .hasPreviousPage)
        try container.encodeIfPresent (items, forKey: .items)
    }
    
    // Hashable
    override func hash(into hasher: inout Hasher) {
        super.hash(into: &hasher)
        
        // Hash specification for model
        hasher.combine(resultCount)
        hasher.combine(start)
        hasher.combine(page)
        hasher.combine(pageCount)
        hasher.combine(itemsPerPage)
        hasher.combine(hasNextPage)
        hasher.combine(hasPreviousPage)
        hasher.combine(items)
    }
    
    // CodingKeys for properties
    enum CodingKeys: String, CodingKey {
        
        // Paging
        case resultCount = "resultCount"
        case start = "start"
        case page = "page"
        case pageCount = "pageCount"
        case itemsPerPage = "itemsPerPage"
        case hasNextPage = "hasNextPage"
        case hasPreviousPage = "hasPreviousPage"
        
        // Items
        case items = "items"
    }
}
