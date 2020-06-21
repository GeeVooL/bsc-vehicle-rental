//
//  InvoiceItem.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 12/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

@objc(InvoiceItem)
public class InvoiceItem: NSManagedObject, Manageable {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<InvoiceItem> {
        return NSFetchRequest<InvoiceItem>(entityName: "InvoiceItem")
    }
    
    public static var all: [InvoiceItem] = []
    
    // MARK: - Attributes
    
    @NSManaged var name: String?
    @NSManaged var netPrice: NSDecimalNumber?
    @NSManaged var taxRate: NSDecimalNumber?
    
    var grossPrice: Decimal {
        netPrice! as Decimal * (Decimal(integerLiteral: 1) + (taxRate! as Decimal))
    }
    
    @NSManaged public var invoice: Invoice?
    
    // MARK: - Initializers
    
    // Loader initializer
    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    private init(context: NSManagedObjectContext, name: String, netPrice: Decimal, taxRate: Decimal?) {
        let description = NSEntityDescription.entity(forEntityName: "InvoiceItem", in: context)!
        super.init(entity: description, insertInto: context)
        addToAll()
        
        self.name = name
        self.netPrice = netPrice as NSDecimalNumber
        self.taxRate = taxRate as NSDecimalNumber? ?? 0.23
    }
    
    // MARK: - Helpers
    
    public static func createInvoiceItem(context: NSManagedObjectContext,
                                         invoice: Invoice,
                                         name: String,
                                         netPrice: Decimal,
                                         taxRate: Decimal?) -> InvoiceItem {
        let item = InvoiceItem(context: context, name: name, netPrice: netPrice, taxRate: taxRate)
        item.invoice = invoice
        return item
    }
    
}
