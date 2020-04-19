//
//  PersistableClassExtension.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 18/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

class PersistentClassExtension<T>: ClassExtension<T> where T: ManagedObjectMappable {
    func save(in container: NSPersistentContainer) {
        let managedContext = container.viewContext
        for object in self.objects {
            do {
                try object.save(context: managedContext)
            } catch let error {
                Swift.print("Cannot save object: \(error).")
            }
        }
        
    }
    
    func load(from container: NSPersistentContainer) {
        let managedContext = container.viewContext
        
        do {
            let fetchedObjects = try managedContext.fetch(T.fetchRequest)
            for object in fetchedObjects {
                do {
                    // init automatically registers the object
                    var _ = try T(from: object)
                    managedContext.delete(object)
                } catch let error {
                    Swift.print("Cannot save object: \(error).")
                }
            }
            try managedContext.save()
        } catch let error as NSError {
            Swift.print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

}

protocol IncludingPersistentExtension: DescriptiveStringConvertible, ManagedObjectMappable {
    associatedtype PersistableExtensionType where PersistableExtensionType: ManagedObjectMappable
    static var all: PersistentClassExtension<PersistableExtensionType> { get set }
}
