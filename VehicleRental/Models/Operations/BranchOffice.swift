//
//  BranchOffice.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 12/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation

class BranchOffice {
    let address: Address
    let garageCapacity: UInt

    init(address: Address, garageCapacity: UInt) {
        self.address = address
        self.garageCapacity = garageCapacity
    }
}
