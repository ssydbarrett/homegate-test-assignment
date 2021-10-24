//
//  PropertyModel.swift
//  HomegateTestAssignmentUIKit
//
//  Created by Vladimir Lukic on 24.10.21..
//

import UIKit

class PropertyModel: BaseModel {
    
    // MARK:- Properties
    
    // Id
    var advertisementId: Int? = -1
    
    // Property info
    var score: Float? = 0.0
    var title: String? = ""
    var description: String? = ""
    var objectCategory: String? = ""
    var objectType: Int? = 0
    var objectTypeLabel: String? = ""
    var numberRooms: Float? = 0
    var floor: Int? = 0
    var floorLabel: String? = ""
    var surfaceLiving: Int? = 0
    var surfaceUsable: Int? = 0
    var balcony: Bool? = false
    
    // Location info
    var street: String? = ""
    var zip: String? = ""
    var text: String? = ""
    var city: String? = ""
    var country: String? = ""
    var countryLabel: String? = ""
    var geoLocation: String? = ""
    
    // Price
    var offerType: String? = ""
    var currency: String? = ""
    var price: Int? = 0
    var sellingPrice: Int? = 0
    var priceUnit: String? = ""
           
    // Pictures
    var picFilename1Small: String? = ""
    var picFilename1Medium: String? = ""
    var pictures: [String]? = [String]()
    
    // Not sure :D
    var listingType: String? = ""
    var interestedFormType: Int? = -1
    
    // Agency
    var agencyId: String? = ""
    var agencyLogoUrl: String? = ""
    var agencyPhoneDay: String? = ""
    var contactPerson: String? = ""
    var contactPhone: String? = ""
    
    // Urls
    var externalUrls: [ExternalUrlModel]? = [ExternalUrlModel]()
    
    // MARK:- Constructors
    
    override init() {
        super.init()
    }
    
    // Decoding
    required init (from decoder: Decoder) throws {
        try super.init(from: decoder)
        
        // Add specification for model
        let container =  try decoder.container (keyedBy: CodingKeys.self)
        advertisementId = try container.decodeIfPresent (Int.self, forKey: .advertisementId)
        score = try container.decodeIfPresent (Float.self, forKey: .score)
        title = try container.decodeIfPresent (String.self, forKey: .title)
        description = try container.decodeIfPresent (String.self, forKey: .description)
        objectCategory = try container.decodeIfPresent (String.self, forKey: .objectCategory)
        objectType = try container.decodeIfPresent (Int.self, forKey: .objectType)
        objectTypeLabel = try container.decodeIfPresent (String.self, forKey: .objectTypeLabel)
        numberRooms = try container.decodeIfPresent (Float.self, forKey: .numberRooms)
        floor = try container.decodeIfPresent (Int.self, forKey: .floor)
        floorLabel = try container.decodeIfPresent (String.self, forKey: .floorLabel)
        surfaceLiving = try container.decodeIfPresent (Int.self, forKey: .surfaceLiving)
        surfaceUsable = try container.decodeIfPresent (Int.self, forKey: .surfaceUsable)
        balcony = try container.decodeIfPresent (Bool.self, forKey: .balcony)
        street = try container.decodeIfPresent (String.self, forKey: .street)
        zip = try container.decodeIfPresent (String.self, forKey: .zip)
        text = try container.decodeIfPresent (String.self, forKey: .text)
        city = try container.decodeIfPresent (String.self, forKey: .city)
        country = try container.decodeIfPresent (String.self, forKey: .country)
        countryLabel = try container.decodeIfPresent (String.self, forKey: .countryLabel)
        geoLocation = try container.decodeIfPresent (String.self, forKey: .geoLocation)
        offerType = try container.decodeIfPresent (String.self, forKey: .offerType)
        currency = try container.decodeIfPresent (String.self, forKey: .currency)
        price = try container.decodeIfPresent (Int.self, forKey: .price)
        sellingPrice = try container.decodeIfPresent (Int.self, forKey: .sellingPrice)
        priceUnit = try container.decodeIfPresent (String.self, forKey: .priceUnit)
        picFilename1Small = try container.decodeIfPresent (String.self, forKey: .picFilename1Small)
        picFilename1Medium = try container.decodeIfPresent (String.self, forKey: .picFilename1Medium)
        pictures = try container.decodeIfPresent ([String].self, forKey: .pictures)
        listingType = try container.decodeIfPresent (String.self, forKey: .listingType)
        interestedFormType = try container.decodeIfPresent (Int.self, forKey: .interestedFormType)
        agencyId = try container.decodeIfPresent (String.self, forKey: .agencyId)
        agencyLogoUrl = try container.decodeIfPresent (String.self, forKey: .agencyLogoUrl)
        agencyPhoneDay = try container.decodeIfPresent (String.self, forKey: .agencyLogoUrl)
        contactPerson = try container.decodeIfPresent (String.self, forKey: .contactPerson)
        contactPhone = try container.decodeIfPresent (String.self, forKey: .contactPhone)
        externalUrls = try container.decodeIfPresent ([ExternalUrlModel].self, forKey: .externalUrls)
    }
    
    // Encoding
    override func encode (to encoder: Encoder) throws {
        try super.encode(to: encoder)
        
        // Add specification for model
        var container = encoder.container (keyedBy: CodingKeys.self)
        try container.encodeIfPresent (advertisementId, forKey: .advertisementId)
        try container.encodeIfPresent (score, forKey: .score)
        try container.encodeIfPresent (title, forKey: .title)
        try container.encodeIfPresent (description, forKey: .description)
        try container.encodeIfPresent (objectCategory, forKey: .objectCategory)
        try container.encodeIfPresent (objectType, forKey: .objectType)
        try container.encodeIfPresent (objectTypeLabel, forKey: .objectTypeLabel)
        try container.encodeIfPresent (numberRooms, forKey: .numberRooms)
        try container.encodeIfPresent (floor, forKey: .floor)
        try container.encodeIfPresent (floorLabel, forKey: .floorLabel)
        try container.encodeIfPresent (surfaceLiving, forKey: .surfaceLiving)
        try container.encodeIfPresent (surfaceUsable, forKey: .surfaceUsable)
        try container.encodeIfPresent (balcony, forKey: .balcony)
        try container.encodeIfPresent (street, forKey: .street)
        try container.encodeIfPresent (zip, forKey: .zip)
        try container.encodeIfPresent (text, forKey: .text)
        try container.encodeIfPresent (city, forKey: .city)
        try container.encodeIfPresent (country, forKey: .country)
        try container.encodeIfPresent (countryLabel, forKey: .countryLabel)
        try container.encodeIfPresent (geoLocation, forKey: .geoLocation)
        try container.encodeIfPresent (offerType, forKey: .offerType)
        try container.encodeIfPresent (currency, forKey: .currency)
        try container.encodeIfPresent (price, forKey: .price)
        try container.encodeIfPresent (sellingPrice, forKey: .sellingPrice)
        try container.encodeIfPresent (priceUnit, forKey: .priceUnit)
        try container.encodeIfPresent (picFilename1Small, forKey: .picFilename1Small)
        try container.encodeIfPresent (picFilename1Medium, forKey: .picFilename1Medium)
        try container.encodeIfPresent (pictures, forKey: .pictures)
        try container.encodeIfPresent (listingType, forKey: .listingType)
        try container.encodeIfPresent (interestedFormType, forKey: .interestedFormType)
        try container.encodeIfPresent (agencyId, forKey: .agencyId)
        try container.encodeIfPresent (agencyLogoUrl, forKey: .agencyLogoUrl)
        try container.encodeIfPresent (agencyPhoneDay, forKey: .agencyPhoneDay)
        try container.encodeIfPresent (contactPerson, forKey: .contactPerson)
        try container.encodeIfPresent (contactPhone, forKey: .contactPhone)
        try container.encodeIfPresent (externalUrls, forKey: .externalUrls)
    }
    
    // Hashable
    override func hash(into hasher: inout Hasher) {
        super.hash(into: &hasher)
        
        // Hash specification for model
        hasher.combine(advertisementId)
        hasher.combine(score)
        hasher.combine(title)
        hasher.combine(description)
        hasher.combine(objectCategory)
        hasher.combine(objectType)
        hasher.combine(objectTypeLabel)
        hasher.combine(numberRooms)
        hasher.combine(floor)
        hasher.combine(floorLabel)
        hasher.combine(surfaceLiving)
        hasher.combine(surfaceUsable)
        hasher.combine(balcony)
        hasher.combine(street)
        hasher.combine(zip)
        hasher.combine(text)
        hasher.combine(city)
        hasher.combine(country)
        hasher.combine(countryLabel)
        hasher.combine(geoLocation)
        hasher.combine(offerType)
        hasher.combine(currency)
        hasher.combine(price)
        hasher.combine(sellingPrice)
        hasher.combine(priceUnit)
        hasher.combine(picFilename1Small)
        hasher.combine(picFilename1Medium)
        hasher.combine(pictures)
        hasher.combine(listingType)
        hasher.combine(interestedFormType)
        hasher.combine(agencyId)
        hasher.combine(agencyLogoUrl)
        hasher.combine(agencyPhoneDay)
        hasher.combine(contactPerson)
        hasher.combine(contactPhone)
        hasher.combine(externalUrls)
    }
    
    // Equaleablility :D
    static func == (lhs: PropertyModel, rhs: PropertyModel) -> Bool {
        return lhs.advertisementId == rhs.advertisementId
    }
    
    // CodingKeys for properties
    enum CodingKeys: String, CodingKey {
        
        // Id
        case advertisementId = "advertisementId"
        
        // Property info
        case score = "score"
        case title = "title"
        case description = "description"
        case objectCategory = "objectCategory"
        case objectType = "objectType"
        case objectTypeLabel = "objectTypeLabel"
        case numberRooms = "numberRooms"
        case floor = "floor"
        case floorLabel = "floorLabel"
        case surfaceLiving = "surfaceLiving"
        case surfaceUsable = "surfaceUsable"
        case balcony = "balcony"
        
        // Location info
        case street = "street"
        case zip = "zip"
        case text = "text"
        case city = "city"
        case country = "country"
        case countryLabel = "countryLabel"
        case geoLocation = "geoLocation"
        
        // Price
        case offerType = "offerType"
        case currency = "currency"
        case price = "price"
        case sellingPrice = "sellingPrice"
        case priceUnit = "priceUnit"
               
        // Pictures
        case picFilename1Small = "picFilename1Small"
        case picFilename1Medium = "picFilename1Medium"
        case pictures = "pictures"
        
        // Not sure :D
        case listingType = "listingType"
        case interestedFormType = "interestedFormType"
        
        // Agency
        case agencyId = "agencyId"
        case agencyLogoUrl = "agencyLogoUrl"
        case agencyPhoneDay = "agencyPhoneDay"
        case contactPerson = "contactPerson"
        case contactPhone = "contactPhone"
        
        // Urls
        case externalUrls = "externalUrls"
    }
}


