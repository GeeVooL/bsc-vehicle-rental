//
//  Invoice.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 12/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation

class Invoice {
    let id: UInt
    // TODO(mDevv): implement the below properties when the associations are done
    var totalNet: Decimal?
    var totalGross: Decimal?
    
    init(id: UInt) {
        self.id = id
    }
}
