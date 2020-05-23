//
//  CustomerServiceEmployee.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 11/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

final class CustomerServiceEmployee: Employee, IncludingPersistentExtension, Invalidatable, ReferenceEquatable {
    typealias EntityType = CustomerServiceEmployeeEntity
    
    static var all = PersistentClassExtension<CustomerServiceEmployee>()
    static let bonusPerOrder = 0.05
    
    let name: String
    let surname: String
    let birthDate: Date
    var address: Address
    var email: String
    var phone: String
    let employmentDate: Date
    var baseSalary: Decimal
    var totalOrders: Int32
    var totalBonus: Decimal {
        baseSalary * Decimal(CustomerServiceEmployee.bonusPerOrder) * Decimal(totalOrders)
    }
    
    var isValid: Bool = true
    private var branchOffices: [BranchOffice] = []
    
    init(name: String, surname: String, birthDate: Date, address: Address, email: String, phone: String, employmentDate: Date, baseSalary: Decimal, totalOrders: Int32) {
        self.name = name
        self.surname = surname
        self.birthDate = birthDate
        self.address = address
        self.email = email
        self.phone = phone
        self.employmentDate = employmentDate
        self.baseSalary = baseSalary
        self.totalOrders = totalOrders
        CustomerServiceEmployee.all.add(object: self)
    }
    
    required convenience init(from object: NSManagedObject) throws {
        let entity = object as! EntityType
        let addressString = try JSONDecoder().decode(Address.self, from: entity.address!.data(using: .utf8)!)
        
        self.init(name: entity.name!, surname: entity.surname!, birthDate: entity.birthDate!, address: addressString, email: entity.email!, phone: entity.phone!, employmentDate: entity.employmentDate!, baseSalary: entity.baseSalary! as Decimal, totalOrders: entity.totalOrders)
    }
    
    func invalidate() {
        if !isValid { return }
        
        for b in branchOffices {
            b.removeEmployee(self)
        }
        
        CustomerServiceEmployee.all.remove(object: self)
        isValid = false
    }
    
    func addBranchOffice(_ branchOffice: BranchOffice) {
        if !branchOffices.contains(branchOffice) {
            branchOffices.append(branchOffice);
            
            branchOffice.addEmployee(self);
        }
    }
    
    func removeBranchOffice(_ branchOffice: BranchOffice) {
        if let index = branchOffices.firstIndex(of: branchOffice) {
            let removed = branchOffices.remove(at: index)
            removed.removeEmployee(self)
        }
    }
    
    // Override default implementation from protocol
    func calculateSalary() -> Decimal { baseSalary + totalBonus }
    
    func save(context: NSManagedObjectContext) throws {
        let jsonAddress = try JSONEncoder().encode(address)
        let addressString = String(data: jsonAddress, encoding: .utf8)!
        
        let entity = CustomerServiceEmployeeEntity(context: context)
        entity.name = name
        entity.surname = surname
        entity.birthDate = birthDate
        entity.address = addressString
        entity.email = email
        entity.phone = phone
        entity.employmentDate = employmentDate
        entity.baseSalary = baseSalary as NSDecimalNumber
        entity.totalOrders = totalOrders
        entity.staticBonusPerOrder = Self.bonusPerOrder
        context.insert(entity)
        try context.save()
    }
}
