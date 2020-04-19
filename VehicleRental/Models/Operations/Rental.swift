//
//  Rental.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 12/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

final class Rental: IncludingPersistentExtension {
    typealias EntityType = RentalEntity
    
    static var all = PersistentClassExtension<Rental>()
    
    let rentDate: Date
    let plannedReturnDate: Date
    
    init(rentDate: Date, plannedReturnDate: Date) {
        self.rentDate = rentDate
        self.plannedReturnDate = plannedReturnDate
        Rental.all.add(object: self)
    }
    
    required convenience init(from object: NSManagedObject) throws {
        let entity = object as! EntityType
        self.init(rentDate: entity.rentDate!, plannedReturnDate: entity.plannedReturnDate!)
    }
    
    deinit {
        Rental.all.remove(object: self)
    }
    
    func calculatePrice() -> Decimal {
        // TODO(mDevv): Implement me when the associations are done
        return 0;
    }
    
    func save(context: NSManagedObjectContext) throws {
        let entity = RentalEntity(context: context)
        entity.rentDate = rentDate
        entity.plannedReturnDate = plannedReturnDate
        context.insert(entity)
        try context.save()
    }
}
