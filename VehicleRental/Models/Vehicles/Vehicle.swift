//
//  Vehicle.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 11/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation

protocol Vehicle {
    var brand: String { get }
    var model: String { get }
    var modelYear: UInt { get }
    var colour: String { get }
    var pricePerDay: Decimal { get set }
}
