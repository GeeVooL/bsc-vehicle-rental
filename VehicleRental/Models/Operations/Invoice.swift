//
//  Invoice.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 12/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

final class Invoice: IncludingPersistentExtension {
    typealias EntityType = InvoiceEntity
    
    static var all = PersistentClassExtension<Invoice>()
    
    let id: Int32
    // TODO(mDevv): implement the below properties when the associations are done
    var totalNet: Decimal?
    var totalGross: Decimal?
    
    init(id: Int32) {
        self.id = id
        Invoice.all.add(object: self)
    }
    
    required convenience init(from object: NSManagedObject) throws {
        let entity = object as! EntityType
        self.init(id: entity.id)
    }
    
    deinit {
        Invoice.all.add(object: self)
    }
    
    func save(context: NSManagedObjectContext) throws {
        let entity = InvoiceEntity(context: context)
        entity.id = id
        context.insert(entity)
        try context.save()
    }
}
