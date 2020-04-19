//
//  BranchOffice.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 12/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

final class BranchOffice: IncludingPersistentExtension {
    typealias EntityType = BranchOfficeEntity
    
    static var all = PersistentClassExtension<BranchOffice>()
    
    let address: Address
    let garageCapacity: Int32
    
    init(address: Address, garageCapacity: Int32) {
        self.address = address
        self.garageCapacity = garageCapacity
        BranchOffice.all.add(object: self)
    }
    
    required convenience init(from object: NSManagedObject) throws {
        let entity = object as! EntityType
        let addressString = try JSONDecoder().decode(Address.self, from: entity.address!.data(using: .utf8)!)
        self.init(address: addressString, garageCapacity: entity.garageCapacity)
    }
    
    deinit {
        BranchOffice.all.remove(object: self)
    }
    
    func save(context: NSManagedObjectContext) throws {
        let jsonAddress = try JSONEncoder().encode(address)
        let addressString = String(data: jsonAddress, encoding: .utf8)!
        
        let entity = BranchOfficeEntity(context: context)
        entity.address = addressString
        entity.garageCapacity = garageCapacity
        context.insert(entity)
        try context.save()
    }

}
