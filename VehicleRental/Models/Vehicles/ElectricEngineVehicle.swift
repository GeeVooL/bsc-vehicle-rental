//
//  ElectricEngineVehicle.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 12/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation

class ElectricEngineVehicle: Vehicle {
    let brand: String
    let model: String
    let modelYear: UInt
    let colour: String
    var pricePerDay: Decimal
    let batteryCapacity: Double
    let chargingTime: TimeInterval
    let range: UInt
    
    init(brand: String, model: String, modelYear: UInt, colour: String, pricePerDay: Decimal, batteryCapacity: Double, chargingTime: TimeInterval, range: UInt) {
        self.brand = brand
        self.model = model
        self.modelYear = modelYear
        self.colour = colour
        self.pricePerDay = pricePerDay
        self.batteryCapacity = batteryCapacity
        self.chargingTime = chargingTime
        self.range = range
    }
}
