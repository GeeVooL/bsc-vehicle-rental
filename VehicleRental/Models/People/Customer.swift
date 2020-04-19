//
//  Customer.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 11/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

final class Customer: Person, IncludingPersistentExtension {
    typealias EntityType = CustomerEntity
    
    static var all = PersistentClassExtension<Customer>()
    
    let name: String
    let surname: String
    let birthDate: Date
    var address: Address
    var email: String
    var phone: String
    let registrationDate: Date
    let discount: Double
    
    init(name: String, surname: String, birthDate: Date, address: Address, email: String, phone: String, registrationDate: Date, discount: Double) {
        self.name = name
        self.surname = surname
        self.birthDate = birthDate
        self.address = address
        self.email = email
        self.phone = phone
        self.registrationDate = registrationDate
        self.discount = discount
        Customer.all.add(object: self)
    }
    
    required convenience init(from object: NSManagedObject) throws {
        let entity = object as! EntityType
        let addressString = try JSONDecoder().decode(Address.self, from: entity.address!.data(using: .utf8)!)
        
        self.init(name: entity.name!, surname: entity.surname!, birthDate: entity.birthDate!, address: addressString, email: entity.email!, phone: entity.phone!, registrationDate: entity.registrationDate!, discount: entity.discount)
    }
    
    deinit {
        Customer.all.remove(object: self)
    }
    
    func rentVehicle() {
        // TODO(mDevv): Implement me.
    }
    
    static func listRentingCustomers() {
        // TODO(mDevv): Implement me.
    }
    
    func save(context: NSManagedObjectContext) throws {
        let encoder = JSONEncoder()
        let jsonAddress = try encoder.encode(address)
        let addressString = String(data: jsonAddress, encoding: .utf8)!
        
        let entity = CustomerEntity(context: context)
        entity.name = name
        entity.surname = surname
        entity.birthDate = birthDate
        entity.address = addressString
        entity.email = email
        entity.phone = phone
        entity.registrationDate = registrationDate
        entity.discount = discount
        context.insert(entity)
        try context.save()
    }
}
