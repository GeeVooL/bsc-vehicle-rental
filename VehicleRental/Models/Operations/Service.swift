//
//  Service.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 12/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

final class Service: IncludingPersistentExtension, Invalidatable, ReferenceEquatable {
    typealias EntityType = ServiceEntity
    
    static var all = PersistentClassExtension<Service>()
    
    let serviceDate: Date
    let issueDescription: String
    
    var isValid: Bool = true
    
    init(serviceDate: Date, issueDescription: String) {
        self.serviceDate = serviceDate
        self.issueDescription = issueDescription
        Service.all.add(object: self)
    }
    
    required convenience init(from object: NSManagedObject) throws {
        let entity = object as! EntityType
        self.init(serviceDate: entity.serviceDate!, issueDescription: entity.issueDescription!)
    }
    
    func invalidate() {
        if !isValid { return }
        
        Service.all.remove(object: self)
        isValid = false
    }
    
    func save(context: NSManagedObjectContext) throws {
        let entity = ServiceEntity(context: context)
        entity.serviceDate = serviceDate
        entity.issueDescription = issueDescription
        context.insert(entity)
        try context.save()
    }
}
