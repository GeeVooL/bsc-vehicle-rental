//
//  AutomobileVehicle.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 12/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation

final class AutomobileVehicle: Vehicle, IncludingExtension {
    static var all = ClassExtension<AutomobileVehicle>()
    
    let brand: String
    let model: String
    let modelYear: UInt
    let colour: String
    var pricePerDay: Decimal
    let trunkSize: UInt
    let numberOfSeats: UInt
    let hasAircondition: Bool
    
    init(brand: String, model: String, modelYear: UInt, colour: String, pricePerDay: Decimal, trunkSize: UInt, numberOfSeats: UInt, hasAircondition: Bool) {
        self.brand = brand
        self.model = model
        self.modelYear = modelYear
        self.colour = colour
        self.pricePerDay = pricePerDay
        self.trunkSize = trunkSize
        self.numberOfSeats = numberOfSeats
        self.hasAircondition = hasAircondition
        AutomobileVehicle.all.add(object: self)
    }
    
    deinit {
        AutomobileVehicle.all.remove(object: self)
    }
}
