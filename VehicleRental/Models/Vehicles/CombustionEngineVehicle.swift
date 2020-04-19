//
//  CombustionEngineVehicle.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 12/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

class CombustionEngineVehicle: Vehicle, IncludingPersistentExtension {
    typealias EntityType = CombustionEngineVehicleEntity
    
    static var all = PersistentClassExtension<CombustionEngineVehicle>()
    
    let brand: String
    let model: String
    let modelYear: Int32
    let color: String
    var pricePerDay: Decimal
    let averageFuelConsumption: Double
    let tankCapacity: Double
    
    init(brand: String, model: String, modelYear: Int32, colour: String, pricePerDay: Decimal, averageFuelConsumption: Double, tankCapacity: Double) {
        self.brand = brand
        self.model = model
        self.modelYear = modelYear
        self.color = colour
        self.pricePerDay = pricePerDay
        self.averageFuelConsumption = averageFuelConsumption
        self.tankCapacity = tankCapacity
        CombustionEngineVehicle.all.add(object: self)
    }
    
    required convenience init(from object: NSManagedObject) throws {
        let entity = object as! CombustionEngineVehicleEntity
        
        self.init(brand: entity.brand!, model: entity.model!, modelYear: entity.modelYear, colour: entity.color!, pricePerDay: entity.pricePerDay! as Decimal, averageFuelConsumption: entity.averageFuelConsumption, tankCapacity: entity.tankCapacity)
    }
    
    deinit {
        CombustionEngineVehicle.all.remove(object: self)
    }
    
    func save(context: NSManagedObjectContext) throws {
        let entity = CombustionEngineVehicleEntity(context: context)
        entity.brand = brand
        entity.model = model
        entity.modelYear = modelYear
        entity.color = color
        entity.pricePerDay = pricePerDay as NSDecimalNumber
        entity.averageFuelConsumption = averageFuelConsumption
        entity.tankCapacity = tankCapacity
        context.insert(entity)
        try context.save()
    }
    
}
