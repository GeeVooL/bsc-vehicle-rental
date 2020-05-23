//
//  ElectricEngineVehicle.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 12/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

class ElectricEngineVehicle: Vehicle, IncludingPersistentExtension, Invalidatable, ReferenceEquatable {
    typealias EntityType = ElectricEngineVehicleEntity
    
    static var all = PersistentClassExtension<ElectricEngineVehicle>()
    
    let registrationNumber: String
    let brand: String
    let model: String
    let modelYear: Int32
    let color: String
    var pricePerDay: Decimal
    let batteryCapacity: Double
    let chargingTime: Int32
    let range: Int32
    
    var isValid: Bool = true
    var branchOffices: [BranchOffice] = []
    var rentals: [Rental] = []
    
    init(registrationNumber: String, brand: String, model: String, modelYear: Int32, colour: String, pricePerDay: Decimal, batteryCapacity: Double, chargingTime: Int32, range: Int32) {
        self.registrationNumber = registrationNumber
        self.brand = brand
        self.model = model
        self.modelYear = modelYear
        self.color = colour
        self.pricePerDay = pricePerDay
        self.batteryCapacity = batteryCapacity
        self.chargingTime = chargingTime
        self.range = range
        ElectricEngineVehicle.all.add(object: self)
    }
    
    required convenience init(from object: NSManagedObject) throws {
        let entity = object as! EntityType
        self.init(registrationNumber: entity.registrationNumber!, brand: entity.brand!, model: entity.model!, modelYear: entity.modelYear, colour: entity.color!, pricePerDay: entity.pricePerDay! as Decimal, batteryCapacity: entity.batteryCapacity, chargingTime: entity.chargingTime, range: entity.range)
    }
    
    func invalidate() {
        if !isValid { return }
        
        for b in branchOffices {
            b.removeVehicle(self)
        }
        
        for r in rentals {
            r.invalidate()
        }
        
        ElectricEngineVehicle.all.remove(object: self)
        isValid = false
    }
    
    func save(context: NSManagedObjectContext) throws {
        let entity = ElectricEngineVehicleEntity(context: context)
        entity.brand = brand
        entity.model = model
        entity.modelYear = modelYear
        entity.color = color
        entity.pricePerDay = pricePerDay as NSDecimalNumber
        entity.batteryCapacity = batteryCapacity
        entity.chargingTime = chargingTime
        entity.range = range
        context.insert(entity)
        try context.save()
    }
}
