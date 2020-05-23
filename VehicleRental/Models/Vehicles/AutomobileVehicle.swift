//
//  AutomobileVehicle.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 12/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

class AutomobileVehicle: Vehicle, IncludingPersistentExtension, Invalidatable, ReferenceEquatable {
    typealias EntityType = AutomobileVehicleEntity
    
    static var all = PersistentClassExtension<AutomobileVehicle>()
    
    let registrationNumber: String
    let brand: String
    let model: String
    let modelYear: Int32
    let color: String
    var pricePerDay: Decimal
    let trunkSize: Int32
    let numberOfSeats: Int32
    let hasAircondition: Bool
    
    var isValid: Bool = true
    var branchOffices: [BranchOffice] = []
    var rentals: [Rental] = []
    
    init(registrationNumber: String, brand: String, model: String, modelYear: Int32, color: String, pricePerDay: Decimal, trunkSize: Int32, numberOfSeats: Int32, hasAircondition: Bool) {
        self.registrationNumber = registrationNumber
        self.brand = brand
        self.model = model
        self.modelYear = modelYear
        self.color = color
        self.pricePerDay = pricePerDay
        self.trunkSize = trunkSize
        self.numberOfSeats = numberOfSeats
        self.hasAircondition = hasAircondition
        AutomobileVehicle.all.add(object: self)
    }
    
    required convenience init(from object: NSManagedObject) throws {
        let entity = object as! EntityType
        self.init(registrationNumber: entity.registrationNumber!, brand: entity.brand!, model: entity.model!, modelYear: entity.modelYear, color: entity.color!, pricePerDay: entity.pricePerDay! as Decimal, trunkSize: entity.trunkSize, numberOfSeats: entity.numberOfSeats, hasAircondition: entity.hasAircondition)
    }
    
    func invalidate() {
        if !isValid { return }
        
        for b in branchOffices {
            b.removeVehicle(self)
        }
        
        for r in rentals {
            r.invalidate()
        }
        
        AutomobileVehicle.all.remove(object: self)
        isValid = false
    }
    
    func save(context: NSManagedObjectContext) throws {
        let entity = AutomobileVehicleEntity(context: context)
        entity.brand = brand
        entity.model = model
        entity.modelYear = modelYear
        entity.color = color
        entity.pricePerDay = pricePerDay as NSDecimalNumber
        entity.trunkSize = trunkSize
        entity.numberOfSeats = numberOfSeats
        entity.hasAircondition = hasAircondition
        context.insert(entity)
        try context.save()
    }

}
