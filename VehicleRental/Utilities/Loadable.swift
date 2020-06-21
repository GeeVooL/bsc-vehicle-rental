//
//  Loadable.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 16/06/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

protocol Manageable: class {
    
    associatedtype EntityType: NSFetchRequestResult
    
    static func fetchRequest() -> NSFetchRequest<EntityType>
    
    static func load(context: NSManagedObjectContext)
    
    static var all: [EntityType] { get set }
    
}

extension Manageable {
    
    static func load(context: NSManagedObjectContext) {
        
        let request = Self.fetchRequest()
        
        do {
            Self.all = try context.fetch(request)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
}
