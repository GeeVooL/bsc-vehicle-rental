//
//  DynamicInheritance.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 07/06/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation

class Human {
    let name: String
    let surname: String
    let birthDate: Date
    
    // Subclasses attributes
    private var worker: Worker?
    private var drugAddict: DrugAddict?
    
    var companyName: String? {
        return worker?.companyName
    }
    var income: Decimal? {
        return worker?.income
    }
    var favouriteDrug: String? {
        return drugAddict?.favouriteDrug
    }
    var spendings: Decimal? {
        return drugAddict?.spendings
    }
    
    init(name: String, surname: String, birthDate: Date, companyName: String, income: Decimal) {
        self.name = name
        self.surname = surname
        self.birthDate = birthDate
        
        setWorkerRole(companyName: companyName, income: income)
    }
    
    init(name: String, surname: String, birthDate: Date, favouriteDrug: String, spendings: Decimal) {
        self.name = name
        self.surname = surname
        self.birthDate = birthDate
        
        setDrugAddictRole(favouriteDrug: favouriteDrug, spendings: spendings)
    }
    
    func setWorkerRole(companyName: String, income: Decimal) {
        drugAddict = nil
        worker = Worker(human: self, companyName: companyName, income: income)
    }
    
    func setDrugAddictRole(favouriteDrug: String, spendings: Decimal) {
        worker = nil
        drugAddict = DrugAddict(human: self, favouriteDrug: favouriteDrug, spendings: spendings)
    }
    
    func getBalance() -> Decimal {
        var balance = Decimal(0)
        
        if let worker = self.worker {
            balance += worker.getBalance()
        } else if let drugAddict = self.drugAddict {
            balance += drugAddict.getBalance()
        }
        
        return balance
    }
}

class Worker {
    fileprivate let companyName: String
    fileprivate let income: Decimal
    
    private let human: Human
    
    init(human: Human, companyName: String, income: Decimal) {
        self.human = human
        self.companyName = companyName
        self.income = income
    }
    
    func getBalance() -> Decimal {
        return income;
    }
}

class DrugAddict {
    fileprivate let favouriteDrug: String
    fileprivate var spendings: Decimal
    
    private let human: Human
    
    init(human: Human, favouriteDrug: String, spendings: Decimal) {
        self.human = human
        self.favouriteDrug = favouriteDrug
        self.spendings = spendings
    }
    
    func getBalance() -> Decimal {
        return -1 * spendings;
    }
}

