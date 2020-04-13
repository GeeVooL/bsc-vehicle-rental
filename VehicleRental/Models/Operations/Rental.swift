//
//  Rental.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 12/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation

final class Rental: IncludingExtension {
    static var all = ClassExtension<Rental>()
    
    let rentDate: Date
    let plannedReturnDate: Date
    
    init(rentDate: Date, plannedReturnDate: Date) {
        self.rentDate = rentDate
        self.plannedReturnDate = plannedReturnDate
        Rental.all.add(object: self)
    }
    
    deinit {
        Rental.all.remove(object: self)
    }
    
    func calculatePrice() -> Decimal {
        // TODO(mDevv): Implement me when the associations are done
        return 0;
    }
}
