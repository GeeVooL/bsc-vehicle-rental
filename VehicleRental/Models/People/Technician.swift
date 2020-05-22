//
//  Mechanic.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 11/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

final class Technician: Employee, IncludingPersistentExtension {
    typealias EntityType = TechnicianEntity
    
    static var all = PersistentClassExtension<Technician>()
    
    enum Specialization: Int32 {
        case electronics = 0
        case mechanics = 1
        case vulcanization = 2
    }
    
    let name: String
    let surname: String
    let birthDate: Date
    var address: Address
    var email: String
    var phone: String
    let employmentDate: Date
    var baseSalary: Decimal
    var specialization: Specialization
    
    init(name: String, surname: String, birthDate: Date, address: Address, email: String, phone: String, employmentDate: Date, baseSalary: Decimal, specialization: Specialization) {
        self.name = name
        self.surname = surname
        self.birthDate = birthDate
        self.address = address
        self.email = email
        self.phone = phone
        self.employmentDate = employmentDate
        self.baseSalary = baseSalary
        self.specialization = specialization
        Technician.all.add(object: self)
    }
    
    required convenience init(from object: NSManagedObject) throws {
        let entity = object as! EntityType
        let addressString = try JSONDecoder().decode(Address.self, from: entity.address!.data(using: .utf8)!)
        
        self.init(name: entity.name!, surname: entity.surname!, birthDate: entity.birthDate!, address: addressString, email: entity.email!, phone: entity.phone!, employmentDate: entity.employmentDate!, baseSalary: entity.baseSalary! as Decimal, specialization: Specialization(rawValue: entity.specialization)!)
    }
    
    deinit {
        Technician.all.remove(object: self)
    }
    
    func serviceVehicle() {
        // TODO(mDevv): Implement me.
    }
    
    func save(context: NSManagedObjectContext) throws {
        let jsonAddress = try JSONEncoder().encode(address)
        let addressString = String(data: jsonAddress, encoding: .utf8)!
        
        let entity = TechnicianEntity(context: context)
        entity.name = name
        entity.surname = surname
        entity.birthDate = birthDate
        entity.address = addressString
        entity.email = email
        entity.phone = phone
        entity.employmentDate = employmentDate
        entity.baseSalary = baseSalary as NSDecimalNumber
        context.insert(entity)
        try context.save()
    }
}
