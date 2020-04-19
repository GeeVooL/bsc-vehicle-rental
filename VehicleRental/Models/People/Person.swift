//
//  Person.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 11/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation

protocol Person {
    var name: String { get set }
    var surname: String { get set }
    var birthDate: Date { get }
    var address: Address { get set }
    var email: String { get set }
    var phone: String { get set }
    
    // MP1 specific
    var middleName: String? { get set }
    mutating func setName(name: String, surname: String)
    mutating func setName(name: String, middleName: String, surname: String)
}

extension Person {
    mutating func setName(name: String, surname: String) {
        self.name = name
        self.surname = surname
    }

    mutating func setName(name: String, middleName: String, surname: String) {
        self.name = name
        self.middleName = middleName
        self.surname = surname
    }
}
