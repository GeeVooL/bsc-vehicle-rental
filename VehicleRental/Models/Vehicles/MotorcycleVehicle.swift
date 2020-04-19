//
//  MotorcycleVehicle.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 12/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

class MotorcycleVehicle: Vehicle, IncludingPersistentExtension {
    typealias EntityType = MotorcycleVehicleEntity
    
    enum MotorcycleType: Int32 {
        case scooter, motorbike
    }
    
    static var all = PersistentClassExtension<MotorcycleVehicle>()
    
    let brand: String
    let model: String
    let modelYear: Int32
    let color: String
    var pricePerDay: Decimal
    let type: MotorcycleType
    var hasWindshield: Bool
    var trunkSizes: [Int32]
    
    init(brand: String, model: String, modelYear: Int32, colour: String, pricePerDay: Decimal, type: MotorcycleVehicle.MotorcycleType, hasWindshield: Bool, trunkSizes: [Int32]) {
        self.brand = brand
        self.model = model
        self.modelYear = modelYear
        self.color = colour
        self.pricePerDay = pricePerDay
        self.type = type
        self.hasWindshield = hasWindshield
        self.trunkSizes = trunkSizes
        MotorcycleVehicle.all.add(object: self)
    }
    
    required convenience init(from object: NSManagedObject) throws {
        let entity = object as! EntityType
        self.init(brand: entity.brand!, model: entity.model!, modelYear: entity.modelYear, colour: entity.color!, pricePerDay: entity.pricePerDay! as Decimal, type: MotorcycleType(rawValue: entity.type)!, hasWindshield: entity.hasWindshield, trunkSizes: entity.trunkSizes!)
    }
    
    deinit {
        MotorcycleVehicle.all.remove(object: self)
    }
    
    func save(context: NSManagedObjectContext) throws {
        let entity = MotorcycleVehicleEntity(context: context)
        entity.brand = brand
        entity.model = model
        entity.modelYear = modelYear
        entity.color = color
        entity.pricePerDay = pricePerDay as NSDecimalNumber
        entity.type = type.rawValue
        entity.hasWindshield = hasWindshield
        entity.trunkSizes = trunkSizes
        context.insert(entity)
        try context.save()
    }
}
