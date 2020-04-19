//
//  ManagedObjectMappable.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 18/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

protocol ManagedObjectMappable {
    associatedtype EntityType
    static var fetchRequest: NSFetchRequest<NSManagedObject> { get }

    init(from object: NSManagedObject) throws
    
    func save(context: NSManagedObjectContext) throws
}

extension ManagedObjectMappable {
    static var fetchRequest: NSFetchRequest<NSManagedObject> {
        return NSFetchRequest<NSManagedObject>(entityName: String(describing: EntityType.self))
    }
}
