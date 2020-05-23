//
//  InvoiceItem.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 12/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

final class InvoiceItem: IncludingPersistentExtension, Invalidatable, ReferenceEquatable {
    typealias EntityType = InvoiceItemEntity
    
    static var all = PersistentClassExtension<InvoiceItem>()
    static let vatTax = 0.23
    
    let name: String
    let netPrice: Decimal
    var grossPrice: Decimal { netPrice * (Decimal(1) + Decimal(InvoiceItem.vatTax)) }
    
    var isValid: Bool = true
    fileprivate var invoice: Invoice? = nil
    
    static func create(invoice: Invoice, name: String, netPrice: Decimal) -> InvoiceItem? {
        let item = InvoiceItem(name: name, netPrice: netPrice)
        item.invoice = invoice
        let success = invoice.addItem(item)
        
        return success ? item : nil
    }
    
    private init(name: String, netPrice: Decimal) {
        self.name = name
        self.netPrice = netPrice
        InvoiceItem.all.add(object: self)
    }
    
    required convenience init(from object: NSManagedObject) throws {
        let entity = object as! EntityType
        self.init(name: entity.name!, netPrice: entity.netPrice! as Decimal)
    }
    
    func invalidate() {
        if !isValid { return }
        
        InvoiceItem.all.remove(object: self)
        
        isValid = false
    }
    
    func save(context: NSManagedObjectContext) throws {
        let entity = InvoiceItemEntity(context: context)
        entity.name = name
        entity.netPrice = netPrice as NSDecimalNumber
        context.insert(entity)
        try context.save()
    }
}
