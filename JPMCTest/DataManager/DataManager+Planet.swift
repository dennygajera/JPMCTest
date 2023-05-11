//
//  DataManager+Planet.swift
//  JPMCTest
//
//  Created by Darshan Gajera on 08/05/2023.
//

import Foundation
import CoreData

extension DataManager {
    
    // MARK: Create/ Update Object
    public func createOrUpdateManagedObjects(using jsonObjects: [[String : Any]], mappedTo entityName: String, context: NSManagedObjectContext? = nil, save: Bool = false) {
        
        let context = context ?? viewContext
        
        context.performAndWait { [unowned self] in
            guard !jsonObjects.isEmpty else { return }
            
            let primaryKeys = jsonObjects.map { $0["url"] } as! [String]
            let existingObjects = fetchManagedObjects(matchingIDs: primaryKeys, entityName: entityName, context: context)
            
            jsonObjects.forEach { jsonObject in
                let primaryKey = jsonObject["url"] as! String
                let manageObject = existingObjects.filter { $0.value(forKey: "url") as? String ==  primaryKey }.first ?? createManagedObject(for: entityName)
          
                updateManagedObject(manageObject!, usingJSON: jsonObject)
           }
            
            if save {
                saveContext(context)
            }
        }
    }
    
    public func createManagedObject(for entityName: String, context: NSManagedObjectContext? = nil) -> NSManagedObject? {
        let newObject = NSEntityDescription.insertNewObject(
            forEntityName: entityName,
            into: context ?? viewContext
        )
        return newObject
    }
    
    public func fetchManagedObjects(matchingIDs: [String], entityName: String, context: NSManagedObjectContext? = nil) -> [NSManagedObject] {
        var predicate: NSPredicate!
        let context = context ?? viewContext
        predicate = NSPredicate(format: "url IN %@", matchingIDs)
        return fetchManagedObjects(entityName: entityName, predicate: predicate, context: context)
    }
    
    public func fetchManagedObjects(entityName: String, predicate: NSPredicate? = nil,  sortDescriptors: [NSSortDescriptor]? = nil, maxResults: Int? = nil, context: NSManagedObjectContext? = nil) -> [NSManagedObject] {
        let context = context ?? viewContext
        let sortDescriptors = sortDescriptors
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.predicate = predicate
        if let maxResults = maxResults {
            request.fetchLimit = maxResults
        }
        
        request.sortDescriptors = sortDescriptors
        return try! context.fetch(request) as? [NSManagedObject] ?? []
    }
    
    public func updateManagedObject(_ managedObject: NSManagedObject, usingJSON responseObject: [String: Any]) {
        
        managedObject.entity.propertiesByName.keys.forEach { localKey in
            
            let jsonKey = responseObject.keys.filter { $0.lowercased() == localKey.lowercased() }.first
            
            guard let jsonKey = jsonKey else { return }
            let value = responseObject[jsonKey]
            
            if let strVal = value as? String {
                managedObject.setValue(strVal, forKey: localKey)
            } else if let boolVal = value as? Bool {
                managedObject.setValue(boolVal, forKey: localKey)
            } else if let doubleVal = value as? Double {
                managedObject.setValue(doubleVal, forKey: localKey)
            } else if let intVal = value as? Int {
                managedObject.setValue(intVal, forKey: localKey)
            } else if let arrayVal = value as? [String] {
                managedObject.setValue(arrayVal.joined(separator: ","), forKey: localKey)
            } else {
                managedObject.setValue(nil, forKey: localKey)
            }
        }
    }
}
