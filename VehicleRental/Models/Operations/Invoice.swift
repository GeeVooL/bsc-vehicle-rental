//
//  Invoice.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 12/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

@objc(Invoice)
public class Invoice: NSManagedObject, Manageable {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Invoice> {
        return NSFetchRequest<Invoice>(entityName: "Invoice")
    }
    
    public static var all: [Invoice] = []
    
    // MARK: - Attributes
    
    @NSManaged var id: String?
    
    @NSManaged var items: Set<InvoiceItem>?
    @NSManaged private var rental: Rental?
    @NSManaged private var service: Service?
    
    var netPrice: Decimal {
        var sum = Decimal(0)
        if let items = items {
            for item in items {
                sum += (item.netPrice! as Decimal)
            }
        }
        return sum
    }
    
    var grossPrice: Decimal {
        var sum = Decimal(0)
        if let items = items {
            for item in items {
                sum += (item.grossPrice)
            }
        }
        return sum
    }
    
    // MARK: - CoreData helpers
    
    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: InvoiceItem)
    
    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: InvoiceItem)
    
    @objc(addItems:)
    @NSManaged public func addToItems(_ values: Set<InvoiceItem>)
    
    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: Set<InvoiceItem>)
    
    // MARK: - Initializers
    
    // Loader initializer
    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    public init(context: NSManagedObjectContext) {
        let description = NSEntityDescription.entity(forEntityName: "Invoice", in: context)!
        super.init(entity: description, insertInto: context)
        addToAll()
        
        self.id = UUID().uuidString
    }
    
    public convenience init(context: NSManagedObjectContext, rental: Rental) {
        self.init(context: context)
        setRental(rental: rental)
    }
    
    public convenience init(context: NSManagedObjectContext, service: Service) {
        self.init(context: context)
        setService(service: service)
    }

    // MARK: - Helpers
    
    public func addItem(context: NSManagedObjectContext, name: String, netPrice: Decimal, taxRate: Decimal?) {
        let _ = InvoiceItem.createInvoiceItem(context: context, invoice: self, name: name, netPrice: netPrice, taxRate: taxRate)
    }
    
    public func setService(service: Service) {
        if rental == nil {
            self.service = service
        }
    }
    
    public func getService() -> Service? {
        return self.service
    }
    
    public func setRental(rental: Rental) {
        if service == nil {
            self.rental = rental
        }
    }
    
    public func getRental() -> Rental? {
        return self.rental
    }
    
    // MARK: - Business logic
    
    /// Apply the customer's discount to the invoice
    public func discount() {
        // TODO(mDevv): Implement me
    }
}
