//
//  HybridVehicle.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 12/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation

class HybridVehicle {
    enum HybridType {
        case mild, full, plugIn
    }
    
    let type: HybridType
    let maxSpeedUsingElectricEngine: Float
    
    init(type: HybridVehicle.HybridType, maxSpeedUsingElectricEngine: Float) {
        self.type = type
        self.maxSpeedUsingElectricEngine = maxSpeedUsingElectricEngine
    }
}
