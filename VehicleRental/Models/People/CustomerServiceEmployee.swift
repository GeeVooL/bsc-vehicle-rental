//
//  CustomerServiceEmployee.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 11/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation

final class CustomerServiceEmployee: Employee, IncludingExtension {
    static var all = ClassExtension<CustomerServiceEmployee>()
    static let bonusPerOrder = 0.05
    
    let name: String
    let surname: String
    let birthDate: Date
    var address: Address
    var email: String
    var phone: String
    let employmentDate: Date
    var baseSalary: Decimal
    var totalOrders: UInt
    var totalBonus: Decimal {
        baseSalary * Decimal(floatLiteral: CustomerServiceEmployee.bonusPerOrder) * Decimal(totalOrders)
    }
    
    init(name: String, surname: String, birthDate: Date, address: Address, email: String, phone: String, employmentDate: Date, baseSalary: Decimal, totalOrders: UInt) {
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
    
    deinit {
        CustomerServiceEmployee.all.remove(object: self)
    }
    
    // Override default implementation from protocol
    func calculateSalary() -> Decimal { baseSalary + totalBonus }
}
