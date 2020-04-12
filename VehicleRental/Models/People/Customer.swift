//
//  Customer.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 11/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation

class Customer: Person {
    let name: String
    let surname: String
    let birthDate: Date
    var address: String
    var email: String
    var phone: String
    let registrationDate: Date
    let discount: Double
    
    init(name: String, surname: String, birthDate: Date, address: String, email: String, phone: String, registrationDate: Date, discount: Double) {
        self.name = name
        self.surname = surname
        self.birthDate = birthDate
        self.address = address
        self.email = email
        self.phone = phone
        self.registrationDate = registrationDate
        self.discount = discount
    }
    
    func rentVehicle() {
        // TODO(mDevv): Implement me.
    }
    
    static func listRentingCustomers() {
        // TODO(mDevv): Implement me.
    }
}