//
//  Mechanic.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 11/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation

final class Technician: Employee, IncludingExtension {
    static var all = ClassExtension<Technician>()
    
    let name: String
    let surname: String
    let birthDate: Date
    var address: Address
    var email: String
    var phone: String
    let employmentDate: Date
    var baseSalary: Decimal
    
    init(name: String, surname: String, birthDate: Date, address: Address, email: String, phone: String, employmentDate: Date, baseSalary: Decimal) {
        self.name = name
        self.surname = surname
        self.birthDate = birthDate
        self.address = address
        self.email = email
        self.phone = phone
        self.employmentDate = employmentDate
        self.baseSalary = baseSalary
        Technician.all.add(object: self)
    }
    
    deinit {
        Technician.all.remove(object: self)
    }
    
    enum Specialization {
        case electronics, mechanics, vulcanization
    }
    
    func serviceVehicle() {
        // TODO(mDevv): Implement me.
    }
}
