//
//  Service.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 12/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

final class Service: IncludingPersistentExtension {
    typealias EntityType = ServiceEntity
    
    static var all = PersistentClassExtension<Service>()
    
    let serviceDate: Date
    let issueDescription: String
    
    init(serviceDate: Date, issueDescription: String) {
        self.serviceDate = serviceDate
        self.issueDescription = issueDescription
        Service.all.add(object: self)
    }
    
    required convenience init(from object: NSManagedObject) throws {
        let entity = object as! EntityType
        self.init(serviceDate: entity.serviceDate!, issueDescription: entity.issueDescription!)
    }
    
    deinit {
        Service.all.remove(object: self)
    }
    
    func save(context: NSManagedObjectContext) throws {
        let entity = ServiceEntity(context: context)
        entity.serviceDate = serviceDate
        entity.issueDescription = issueDescription
        context.insert(entity)
        try context.save()
    }
}
