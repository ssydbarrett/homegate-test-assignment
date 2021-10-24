//
//  CoreDataManager.swift
//  HomegateTestAssignmentUIKit
//
//  Created by Vladimir Lukic on 24.10.21..
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    
    // Notification names
    
    static let notification_favorites_updated = NSNotification.Name("notification_favorites_updated")
    
    // MARK: SELECT
    
    // Check if favorite exists
    class func checkIfFavoriteExists(with advertisementId: Int) throws -> Bool {
        
        // Get app delegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        
        // Get managed context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Create fetch request
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Property")
        fetchRequest.predicate = NSPredicate(format: "advertisementId==\(advertisementId)")
        
        do {
            
            // Get list of single favorites from managed context that
            let singleListOfFavorites: [NSManagedObject] = try managedContext.fetch(fetchRequest)
            
            // Check if exists
            if singleListOfFavorites.count >= 1 {
                return true
            } else {
                return false
            }
            
        // Catch error
        } catch let error as NSError {
            print("Could not check in Core data \(error), \(error.userInfo)")
            throw error
            // return false
        }
    }
    
    // Get all favorites id
    class func fetchAllFavoritesId() throws -> [Int] {
        
        // Get app delegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [Int]() }
        
        // Get managed context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Create fetch request
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Property")
        
        do {
            
            // Get list of all favorites from managed context
            let listOfFavorites: [NSManagedObject] = try managedContext.fetch(fetchRequest)
            
            // Convert to property model
            var favoriteIds = [Int]()
            for favorite in listOfFavorites {
                
                // Append to array
                favoriteIds.append(favorite.value(forKey: "advertisementId") as? Int ?? 0)
            }
            
            // Return favorites array
            return favoriteIds
            
        // Catch error
        } catch let error as NSError {
            print("Could not fetch from Core data \(error), \(error.userInfo)")
            throw error
            // return [Int]()
        }
    }
    
    // Get all favorites
    class func fetchAllFavorites() throws -> [PropertyModel] {
        
        // Get app delegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [PropertyModel]() }
        
        // Get managed context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Create fetch request
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Property")
        
        do {
            
            // Get list of all favorites from managed context
            let listOfFavorites: [NSManagedObject] = try managedContext.fetch(fetchRequest)
            
            // Convert to property model
            var favorites = [PropertyModel]()
            for favorite in listOfFavorites {
                let propertyModel = PropertyModel()
                propertyModel.advertisementId = favorite.value(forKey: "advertisementId") as? Int ?? 0
                propertyModel.score = favorite.value(forKey: "score") as? Float ?? 0
                propertyModel.title = favorite.value(forKey: "title") as? String ?? ""
                propertyModel.description = favorite.value(forKey: "desc") as? String ?? ""
                propertyModel.objectCategory = favorite.value(forKey: "objectCategory") as? String ?? ""
                propertyModel.objectType = favorite.value(forKey: "objectType") as? Int ?? 0
                propertyModel.objectTypeLabel = favorite.value(forKey: "objectTypeLabel") as? String ?? ""
                propertyModel.numberRooms = favorite.value(forKey: "numberRooms") as? Float ?? 0
                propertyModel.floor = favorite.value(forKey: "floor") as? Int ?? 0
                propertyModel.floorLabel = favorite.value(forKey: "floorLabel") as? String ?? ""
                propertyModel.surfaceLiving = favorite.value(forKey: "surfaceLiving") as? Int ?? 0
                propertyModel.surfaceUsable = favorite.value(forKey: "surfaceUsable") as? Int ?? 0
                propertyModel.balcony = favorite.value(forKey: "balcony") as? Bool ?? false
                propertyModel.street = favorite.value(forKey: "street") as? String ?? ""
                propertyModel.zip = favorite.value(forKey: "zip") as? String ?? ""
                propertyModel.text = favorite.value(forKey: "text") as? String ?? ""
                propertyModel.city = favorite.value(forKey: "city") as? String ?? ""
                propertyModel.country = favorite.value(forKey: "country") as? String ?? ""
                propertyModel.countryLabel = favorite.value(forKey: "countryLabel") as? String ?? ""
                propertyModel.geoLocation = favorite.value(forKey: "geoLocation") as? String ?? ""
                propertyModel.offerType = favorite.value(forKey: "offerType") as? String ?? ""
                propertyModel.currency = favorite.value(forKey: "currency") as? String ?? ""
                propertyModel.price = favorite.value(forKey: "price") as? Int ?? 0
                propertyModel.sellingPrice = favorite.value(forKey: "sellingPrice") as? Int ?? 0
                propertyModel.priceUnit = favorite.value(forKey: "priceUnit") as? String ?? ""
                propertyModel.picFilename1 = favorite.value(forKey: "picFilename1") as? String ?? ""
                propertyModel.picFilename1Medium = favorite.value(forKey: "picFilename1Medium") as? String ?? ""
                propertyModel.picFilename1Small = favorite.value(forKey: "picFilename1Small") as? String ?? ""
                propertyModel.listingType = favorite.value(forKey: "listingType") as? String ?? ""
                propertyModel.interestedFormType = favorite.value(forKey: "interestedFormType") as? Int ?? 0
                propertyModel.agencyId = favorite.value(forKey: "agencyId") as? String ?? ""
                propertyModel.agencyLogoUrl = favorite.value(forKey: "agencyLogoUrl") as? String ?? ""
                propertyModel.agencyPhoneDay = favorite.value(forKey: "agencyPhoneDay") as? String ?? ""
                propertyModel.contactPerson = favorite.value(forKey: "contactPerson") as? String ?? ""
                propertyModel.contactPhone = favorite.value(forKey: "contactPhone") as? String ?? ""
                
                // From base model
                propertyModel.timestamp = favorite.value(forKey: "timestamp") as? Int ?? 0
                propertyModel.timestampStr = favorite.value(forKey: "timestampStr") as? String ?? ""
                propertyModel.lastModified = favorite.value(forKey: "lastModified") as? Int ?? 0
                propertyModel.searchInquiryTimestamp = favorite.value(forKey: "searchInquiryTimestamp") as? Int ?? 0
                
                // Get arrays
                propertyModel.pictures = try JSONDecoder().decode([String]?.self, from: favorite.value(forKey: "pictures") as? Data ?? Data())
                propertyModel.externalUrls = try JSONDecoder().decode([ExternalUrlModel]?.self, from: favorite.value(forKey: "externalUrls") as? Data ?? Data())
                
                // Append to array
                favorites.append(propertyModel)
            }
            
            // Return favorites array
            return favorites
            
        // Catch error
        } catch let error as NSError {
            print("Could not fetch from Core data \(error), \(error.userInfo)")
            throw error
            // return [PropertyModel]()
        }
    }
    
    // MARK: UPDATE
    
    // Save favorite
    class func update(favorite: PropertyModel) throws {
        
        // Check if Favorite already exists
        do {
            let favoriteExists = try CoreDataManager.checkIfFavoriteExists(with: favorite.advertisementId ?? -666)
            
            // Delete if exists
            if favoriteExists == true {
                try CoreDataManager.deleteFavorite(with: favorite.advertisementId ?? -666)
            }
            
            // Save if not
            else {
                try CoreDataManager.save(favorite: favorite)
            }
        }
        
        // Catch error
        catch let error as NSError {
            
            // Print error
            print("Could not update to Core data \(error), \(error.userInfo)")
            throw error
        }
    }
    
    // MARK: CREATE
    
    // Save favorite
    class func save(favorite: PropertyModel) throws {
        
        // Get app delegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        // Get managed context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Get entity
        let entity = NSEntityDescription.entity(forEntityName: "Property",
                                   in: managedContext)!
        let property = NSManagedObject(entity: entity, insertInto: managedContext)
        
        // Prepare params to save
        property.setValue(favorite.advertisementId, forKeyPath: "advertisementId")
        property.setValue(favorite.score, forKeyPath: "score")
        property.setValue(favorite.title, forKeyPath: "title")
        property.setValue(favorite.description, forKeyPath: "desc")
        property.setValue(favorite.objectCategory, forKeyPath: "objectCategory")
        property.setValue(favorite.objectType, forKeyPath: "objectType")
        property.setValue(favorite.objectTypeLabel, forKeyPath: "objectTypeLabel")
        property.setValue(favorite.numberRooms, forKeyPath: "numberRooms")
        property.setValue(favorite.floor, forKeyPath: "floor")
        property.setValue(favorite.floorLabel, forKeyPath: "floorLabel")
        property.setValue(favorite.surfaceLiving, forKeyPath: "surfaceLiving")
        property.setValue(favorite.surfaceUsable, forKeyPath: "surfaceUsable")
        property.setValue(favorite.balcony, forKeyPath: "balcony")
        property.setValue(favorite.street, forKeyPath: "street")
        property.setValue(favorite.zip, forKeyPath: "zip")
        property.setValue(favorite.text, forKeyPath: "text")
        property.setValue(favorite.city, forKeyPath: "city")
        property.setValue(favorite.country, forKeyPath: "country")
        property.setValue(favorite.countryLabel, forKeyPath: "countryLabel")
        property.setValue(favorite.geoLocation, forKeyPath: "geoLocation")
        property.setValue(favorite.offerType, forKeyPath: "offerType")
        property.setValue(favorite.currency, forKeyPath: "currency")
        property.setValue(favorite.price, forKeyPath: "price")
        property.setValue(favorite.sellingPrice, forKeyPath: "sellingPrice")
        property.setValue(favorite.priceUnit, forKeyPath: "priceUnit")
        property.setValue(favorite.picFilename1, forKeyPath: "picFilename1")
        property.setValue(favorite.picFilename1Medium, forKeyPath: "picFilename1Medium")
        property.setValue(favorite.picFilename1Small, forKeyPath: "picFilename1Small")
        property.setValue(favorite.listingType, forKeyPath: "listingType")
        property.setValue(favorite.interestedFormType, forKeyPath: "interestedFormType")
        property.setValue(favorite.agencyId, forKeyPath: "agencyId")
        property.setValue(favorite.agencyLogoUrl, forKeyPath: "agencyLogoUrl")
        property.setValue(favorite.agencyPhoneDay, forKeyPath: "agencyPhoneDay")
        property.setValue(favorite.contactPerson, forKeyPath: "contactPerson")
        property.setValue(favorite.contactPhone, forKeyPath: "contactPhone")
        
        // From base model
        property.setValue(favorite.timestamp, forKeyPath: "timestamp")
        property.setValue(favorite.timestampStr, forKeyPath: "timestampStr")
        property.setValue(favorite.lastModified, forKeyPath: "lastModified")
        property.setValue(favorite.searchInquiryTimestamp, forKeyPath: "searchInquiryTimestamp")
        
        do {
            
            // Save arrays
            property.setValue(try JSONEncoder().encode(favorite.pictures), forKeyPath: "pictures")
            property.setValue(try JSONEncoder().encode(favorite.externalUrls), forKeyPath: "externalUrls")
            
            // Save favorite to managed context an new entity
            try managedContext.save()
            
            // Post notification that favorite list is updated
            NotificationCenter.default.post(name: CoreDataManager.notification_favorites_updated, object: nil)
            
        // Catch error
        } catch let error as NSError {
            
            // Print error
            print("Could not save to Core data \(error), \(error.userInfo)")
            throw error
        }
    }
    
    // MARK: DELETE
    
    class func deleteFavorite(with advertisementId: Int) throws {
        
        // Get app delegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        // Get managed context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Create fetch request
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Property")
        fetchRequest.predicate = NSPredicate(format: "advertisementId==\(advertisementId)")
        
        do {
            
            // Get list of single favorites from managed context that
            let singleListOfFavorites: [NSManagedObject] = try managedContext.fetch(fetchRequest)
            
            // No favorites found for deletion
            if singleListOfFavorites.count == 0 {
                return
            }
            
            // Delete object
            managedContext.delete(singleListOfFavorites.first ?? NSManagedObject())
            try managedContext.save()
            
            // Post notification that favorite list is updated
            NotificationCenter.default.post(name: CoreDataManager.notification_favorites_updated, object: nil)
            
        // Catch error
        } catch let error as NSError {
            print("Could not delete from Core data \(error), \(error.userInfo)")
            throw error
        }
    }
}

// Extend NSCoding to allow unarchiving array from data
extension NSCoding where Self: NSObject {
    static func unsecureUnarchived(from data: Data) -> Self? {
        do {
            let unarchiver = try NSKeyedUnarchiver(forReadingFrom: data)
            unarchiver.requiresSecureCoding = false
            let obj = unarchiver.decodeObject(of: self, forKey: NSKeyedArchiveRootObjectKey)
            if let error = unarchiver.error {
                print("Error:\(error)")
            }
            return obj
        } catch {
            print("Error:\(error)")
        }
        return nil
    }
}
