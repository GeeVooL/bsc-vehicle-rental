//
//  HybridVehicle.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 12/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

class HybridVehicle: Vehicle, IncludingPersistentExtension, Invalidatable, ReferenceEquatable {
    typealias EntityType = HybridVehicleEntity
    
    enum HybridType: Int32 {
        case mild, full, plugIn
    }
    
    static var all = PersistentClassExtension<HybridVehicle>()
    
    let registrationNumber: String
    let brand: String
    let model: String
    let modelYear: Int32
    let color: String
    var pricePerDay: Decimal
    let type: HybridType
    let maxSpeedUsingElectricEngine: Float
    
    var isValid: Bool = true
    var branchOffices: [BranchOffice] = []
    var rentals: [Rental] = []
    
    init(registrationNumber: String, brand: String, model: String, modelYear: Int32, colour: String, pricePerDay: Decimal, type: HybridVehicle.HybridType, maxSpeedUsingElectricEngine: Float) {
        self.registrationNumber = registrationNumber
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
        self.init(registrationNumber: entity.registrationNumber!, brand: entity.brand!, model: entity.model!, modelYear: entity.modelYear, colour: entity.color!, pricePerDay: entity.pricePerDay! as Decimal, type: HybridType(rawValue: entity.type)!, maxSpeedUsingElectricEngine: entity.maxSpeedUsingElectricEngine)
    }
    
    func invalidate() {
        if !isValid { return }
        
        for b in branchOffices {
            b.removeVehicle(self)
        }
        
        for r in rentals {
            r.invalidate()
        }
        
        HybridVehicle.all.remove(object: self)
        isValid = false
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
