//
//  Invoice.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 12/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

final class Invoice: IncludingPersistentExtension, Invalidatable, ReferenceEquatable {
    typealias EntityType = InvoiceEntity
    
    static var all = PersistentClassExtension<Invoice>()
    private static var allItems: [InvoiceItem] = []
    
    let id: Int32
    // TODO(mDevv): implement the below properties when the associations are done
    var totalNet: Decimal?
    var totalGross: Decimal?
    
    var isValid: Bool = true
    private var items: [InvoiceItem] = []
    
    init(id: Int32) {
        self.id = id
        Invoice.all.add(object: self)
    }
    
    required convenience init(from object: NSManagedObject) throws {
        let entity = object as! EntityType
        self.init(id: entity.id)
    }
    
    func invalidate() {
        if !isValid { return }
        
        Self.allItems = Self.allItems.filter { !items.contains($0) }
        for i in items {
            i.invalidate()
        }
        
        Invoice.all.remove(object: self)
        isValid = false
    }
    
    func addItem(_ item: InvoiceItem) -> Bool {
        if !items.contains(item) && !Self.allItems.contains(item) {
            items.append(item)
            Self.allItems.append(item)
            
            return true
        } else {
            return false
        }
    }
        
    func save(context: NSManagedObjectContext) throws {
        let entity = InvoiceEntity(context: context)
        entity.id = id
        context.insert(entity)
        try context.save()
    }
}
