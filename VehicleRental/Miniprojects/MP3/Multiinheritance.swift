//
//  Multiinheritance.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 07/06/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation

protocol BasePerson {
    var name: String { get }
    var surname: String { get }
}

protocol Lecturer: BasePerson {
    var salary: Decimal { get }
    var teachingModules: [String] { get }
    
    func getModules() -> [String]
}

protocol Student: BasePerson {
    var tuition: Decimal { get }
    var learningModules: [String] { get }
    
    func getModules() -> [String]
}

class LecturerImpl: Lecturer {
    let name: String
    
    let surname: String
    
    let salary: Decimal
    
    let teachingModules: [String]
    
    init(name: String, surname: String, salary: Decimal, teachingModules: [String]) {
        self.name = name
        self.surname = surname
        self.salary = salary
        self.teachingModules = teachingModules
    }
    
    func getModules() -> [String] {
        return teachingModules
    }
}

class StudentImpl: Student {
    let name: String
    let surname: String
    let tuition: Decimal
    let learningModules: [String]
    
    init(name: String, surname: String, tuition: Decimal, learningModules: [String]) {
        self.name = name
        self.surname = surname
        self.tuition = tuition
        self.learningModules = learningModules
    }
    
    func getModules() -> [String] {
        return learningModules
    }
}

class PhdStudentImpl: Lecturer, Student {
    let name: String
    let surname: String
    let salary: Decimal
    let tuition: Decimal
    let teachingModules: [String]
    let learningModules: [String]
    
    init(name: String, surname: String, salary: Decimal, tuition: Decimal, teachingModules: [String], learningModules: [String]) {
        self.name = name
        self.surname = surname
        self.salary = salary
        self.tuition = tuition
        self.teachingModules = teachingModules
        self.learningModules = learningModules
    }
        
    func getModules() -> [String] {
        return Array(Set(teachingModules + learningModules))
    }
}
