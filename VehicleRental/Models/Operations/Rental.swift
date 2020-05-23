//
//  Rental.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 12/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

final class Rental: IncludingPersistentExtension, Invalidatable, ReferenceEquatable {
    typealias EntityType = RentalEntity
    
    static var all = PersistentClassExtension<Rental>()
    
    let rentDate: Date
    let plannedReturnDate: Date
    
    var isValid: Bool = true
    // TODO(mDevv): make this non-nullable when the associations are implemented in the DB
    var customer: Customer? = nil
    var vehicle: Vehicle? = nil

    init(customer: Customer?, vehicle: Vehicle?, rentDate: Date, plannedReturnDate: Date) {
        self.rentDate = rentDate
        self.plannedReturnDate = plannedReturnDate
        setCustomer(customer)
        setVehicle(vehicle)
        
        Rental.all.add(object: self)
    }
    
    required convenience init(from object: NSManagedObject) throws {
        let entity = object as! EntityType
        self.init(customer: nil, vehicle: nil, rentDate: entity.rentDate!, plannedReturnDate: entity.plannedReturnDate!)
    }
    
    func invalidate() {
        if !isValid { return }
        
        removeCustomer()
        removeVehicle()
        
        Rental.all.remove(object: self)
        isValid = false
    }
    
    func setCustomer(_ customer: Customer?) {
        if self.customer == nil {
            self.customer = customer
            self.customer?.addRental(self)
        }
    }
    
    func removeCustomer() {
        customer?.removeRental(self)
        customer = nil
    }
    
    func setVehicle(_ vehicle: Vehicle?) {
        if self.vehicle == nil {
            self.vehicle = vehicle
            self.vehicle?.addRental(self)
        }
    }
    
    func removeVehicle() {
        vehicle?.removeRental(self)
        vehicle = nil
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
