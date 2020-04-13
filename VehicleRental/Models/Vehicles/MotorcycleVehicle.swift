//
//  MotorcycleVehicle.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 12/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation

class MotorcycleVehicle: Vehicle, IncludingExtension {
    enum MotorcycleType {
        case scooter, motorbike
    }
    
    static var all = ClassExtension<MotorcycleVehicle>()
    
    let brand: String
    let model: String
    let modelYear: UInt
    let colour: String
    var pricePerDay: Decimal
    let type: MotorcycleType
    let hasWindshield: Bool
    let trunkSizes: [UInt]
    
    init(brand: String, model: String, modelYear: UInt, colour: String, pricePerDay: Decimal, type: MotorcycleVehicle.MotorcycleType, hasWindshield: Bool, trunkSizes: [UInt]) {
        self.brand = brand
        self.model = model
        self.modelYear = modelYear
        self.colour = colour
        self.pricePerDay = pricePerDay
        self.type = type
        self.hasWindshield = hasWindshield
        self.trunkSizes = trunkSizes
        MotorcycleVehicle.all.add(object: self)
    }
    
    deinit {
        MotorcycleVehicle.all.remove(object: self)
    }
}
