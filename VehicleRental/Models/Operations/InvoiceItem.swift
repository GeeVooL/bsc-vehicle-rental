//
//  InvoiceItem.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 12/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation

final class InvoiceItem: IncludingExtension {
    static var all = ClassExtension<InvoiceItem>()
    static let vatTax = 0.23
    
    let name: String
    let netPrice: Decimal
    var grossPrice: Decimal { netPrice * (1 + Decimal(InvoiceItem.vatTax)) }
    
    init(name: String, netPrice: Decimal) {
        self.name = name
        self.netPrice = netPrice
        InvoiceItem.all.add(object: self)
    }
    
    deinit {
        InvoiceItem.all.remove(object: self)
    }
}
