//
//  AbstractClass.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 07/06/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation

protocol AbstractClassProtocol: class {
    var base: Int { get set }
    
    func calculateSalary() -> Double;
}

class TestClassA: AbstractClassProtocol {
    var base: Int = 1200;
    let multiplier: Double = 1.2
    
    func calculateSalary() -> Double {
        return Double(base) * multiplier
    }
}

class TestClassB: AbstractClassProtocol {
    var base: Int = 1200
    let bonus: Double = 245.40
    
    func calculateSalary() -> Double {
        return Double(base) + bonus
    }
}
