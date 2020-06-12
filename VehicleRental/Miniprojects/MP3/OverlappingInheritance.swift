//
//  Overlapping.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 07/06/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation

class User {
    let name: String
    let surname: String
    let birthDate: Date
    
    // Subclasses attributes
    private var seller: Seller?
    private var buyer: Buyer?
    
    var companyName: String? {
        return seller?.companyName
    }
    var income: Decimal? {
        return seller?.income
    }
    var discount: Float? {
        return buyer?.discount
    }
    var spendings: Decimal? {
        return buyer?.spendings
    }
    
    init(name: String, surname: String, birthDate: Date, companyName: String, income: Decimal) {
        self.name = name
        self.surname = surname
        self.birthDate = birthDate
        
        addSellerRole(companyName: companyName, income: income)
    }
    
    init(name: String, surname: String, birthDate: Date, discount: Float, spendings: Decimal) {
        self.name = name
        self.surname = surname
        self.birthDate = birthDate
        
        addBuyerRole(discount: discount, spendings: spendings)
    }
    
    func addSellerRole(companyName: String, income: Decimal) {
        if seller != nil {
            self.seller = Seller(user: self, companyName: companyName, income: income)
        }
    }
    
    func addBuyerRole(discount: Float, spendings: Decimal) {
        if buyer != nil {
            self.buyer = Buyer(user: self, discount: discount, spendings: spendings)
        }
    }
    
    func getBalance() -> Decimal {
        var balance = Decimal(0)
        
        if let seller = self.seller {
            balance += seller.getBalance()
        }
        
        if let buyer = self.buyer {
            balance += buyer.getBalance()
        }
        
        return balance
    }
}

class Seller {
    fileprivate let companyName: String
    fileprivate let income: Decimal
    
    private let user: User
    
    init(user: User, companyName: String, income: Decimal) {
        self.user = user
        self.companyName = companyName
        self.income = income
    }
    
    func getBalance() -> Decimal {
        return income;
    }
}

class Buyer {
    fileprivate let discount: Float
    fileprivate var spendings: Decimal
    
    private let user: User
    
    init(user: User, discount: Float, spendings: Decimal) {
        self.user = user
        self.discount = discount
        self.spendings = spendings
    }
    
    func getBalance() -> Decimal {
        return -1 * spendings;
    }
}
