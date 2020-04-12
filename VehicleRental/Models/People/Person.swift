//
//  Person.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 11/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation

protocol Person {
    var name: String { get }
    var surname: String { get }
    var birthDate: Date { get }
    var address: String { get set }
    var email: String { get set }
    var phone: String { get set }
}
