//
//  CombustionEngineVehicle.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 12/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation

class CombustionEngineVehicle: Vehicle {
    let brand: String
    let model: String
    let modelYear: UInt
    let colour: String
    var pricePerDay: Decimal
    let averageFuelConsumption: Double
    let tankCapacity: Double
    
    init(brand: String, model: String, modelYear: UInt, colour: String, pricePerDay: Decimal, averageFuelConsumption: Double, tankCapacity: Double) {
        self.brand = brand
        self.model = model
        self.modelYear = modelYear
        self.colour = colour
        self.pricePerDay = pricePerDay
        self.averageFuelConsumption = averageFuelConsumption
        self.tankCapacity = tankCapacity
    }
}
