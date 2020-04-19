//
//  InvoiceItem.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 12/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

final class InvoiceItem: IncludingPersistentExtension {
    typealias EntityType = InvoiceItemEntity
    
    static var all = PersistentClassExtension<InvoiceItem>()
    static let vatTax = 0.23
    
    let name: String
    let netPrice: Decimal
    var grossPrice: Decimal { netPrice * (Decimal(1) + Decimal(InvoiceItem.vatTax)) }
    
    init(name: String, netPrice: Decimal) {
        self.name = name
        self.netPrice = netPrice
        InvoiceItem.all.add(object: self)
    }
    
    required convenience init(from object: NSManagedObject) throws {
        let entity = object as! EntityType
        self.init(name: entity.name!, netPrice: entity.netPrice! as Decimal)
    }
    
    deinit {
        InvoiceItem.all.remove(object: self)
    }
    
    func save(context: NSManagedObjectContext) throws {
        let entity = InvoiceItemEntity(context: context)
        entity.name = name
        entity.netPrice = netPrice as NSDecimalNumber
        context.insert(entity)
        try context.save()
    }

    // MP1 specific
    static func getMoreExpensiveThan(price: Decimal) -> [InvoiceItem] {
        var items: [InvoiceItem] = []
        for item in InvoiceItem.all.objects {
            if (item.grossPrice > price) {
                items.append(item)
            }
        }
        return items
    }
}
