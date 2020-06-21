//
//  Loadable.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 16/06/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

public protocol Manageable: class, ReferenceEquatable {
    
    associatedtype EntityType: NSManagedObject
    
    /// Extend of the class implementing the protocol
    static var all: [EntityType] { get set }
    
    
    /// Helper function returning a fetch request for the implementing entity class
    static func fetchRequest() -> NSFetchRequest<EntityType>
    
    
    /// Load all the data from the DB to the class's extend
    /// - Parameter context: Managed DB context
    static func load(context: NSManagedObjectContext)
        
    
    /// Delete object from the extend and the DB context
    /// - Parameter context: <#context description#>
    func delete(context: NSManagedObjectContext)
    
    /// Add object to extend
    func addToAll()
    
    /// Remove object from extend
    func removeFromAll()
    
}

extension Manageable {
    
    public static func load(context: NSManagedObjectContext) {
        let request = Self.fetchRequest()
        
        do {
            Self.all = try context.fetch(request)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    public func delete(context: NSManagedObjectContext) {
        context.delete(self as! NSManagedObject)
        self.removeFromAll()
        
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    public func addToAll() {
        Self.all.append(self as! EntityType)
    }
    
    public func removeFromAll() {
        if let index = Self.all.firstIndex(of: self as! EntityType) {
            Self.all.remove(at: index)
        }
    }
    
}
