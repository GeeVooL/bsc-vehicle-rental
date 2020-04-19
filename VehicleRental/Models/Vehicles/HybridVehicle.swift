//
//  HybridVehicle.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 12/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

class HybridVehicle: Vehicle, IncludingPersistentExtension {
    typealias EntityType = HybridVehicleEntity
    
    enum HybridType: Int32 {
        case mild, full, plugIn
    }
    
    static var all = PersistentClassExtension<HybridVehicle>()
    
    var brand: String
    var model: String
    var modelYear: Int32
    var color: String
    var pricePerDay: Decimal
    let type: HybridType
    let maxSpeedUsingElectricEngine: Float
    
    init(brand: String, model: String, modelYear: Int32, colour: String, pricePerDay: Decimal, type: HybridVehicle.HybridType, maxSpeedUsingElectricEngine: Float) {
        self.brand = brand
        self.model = model
        self.modelYear = modelYear
        self.color = colour
        self.pricePerDay = pricePerDay
        self.type = type
        self.maxSpeedUsingElectricEngine = maxSpeedUsingElectricEngine
        HybridVehicle.all.add(object: self)
    }
    
    required convenience init(from object: NSManagedObject) throws {
        let entity = object as! EntityType
        self.init(brand: entity.brand!, model: entity.model!, modelYear: entity.modelYear, colour: entity.color!, pricePerDay: entity.pricePerDay! as Decimal, type: HybridType(rawValue: entity.type)!, maxSpeedUsingElectricEngine: entity.maxSpeedUsingElectricEngine)
    }
    
    deinit {
        HybridVehicle.all.remove(object: self)
    }
    
    func save(context: NSManagedObjectContext) throws {
        let entity = HybridVehicleEntity(context: context)
        entity.brand = brand
        entity.model = model
        entity.modelYear = modelYear
        entity.color = color
        entity.pricePerDay = pricePerDay as NSDecimalNumber
        entity.type = type.rawValue
        entity.maxSpeedUsingElectricEngine = maxSpeedUsingElectricEngine
        context.insert(entity)
        try context.save()
    }
}
