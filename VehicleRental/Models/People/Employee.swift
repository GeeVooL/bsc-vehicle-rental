//
//  Employee.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 11/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation

protocol Employee: Person {
    var employmentDate: Date { get }
    var baseSalary: Decimal { get }
    
    func calculateSalary() -> Decimal
}

extension Employee {
    func calculateSalary() -> Decimal { baseSalary }
}
