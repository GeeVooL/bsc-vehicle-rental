//
//  Vehicle.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 11/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation

protocol Vehicle: class {
    var registrationNumber: String { get }
    var brand: String { get }
    var model: String { get }
    var modelYear: Int32 { get }
    var color: String { get }
    var pricePerDay: Decimal { get set }
    
    // Qualified association
    var branchOffices: [BranchOffice] { get set }
    func addBranchOffice(_ office: BranchOffice) -> Void
    func removeBranchOffice(_ office: BranchOffice) -> Void
    
    // Attributed association
    var rentals: [Rental] { get set }
    func addRental(_ rental: Rental) -> Void
    func removeRental(_ rental: Rental) -> Void
}

extension Vehicle {
    func addBranchOffice(_ office: BranchOffice) -> Void {
        if !branchOffices.contains(office) {
            branchOffices.append(office)
            office.addVehicle(self)
        }
    }
    
    func removeBranchOffice(_ office: BranchOffice) -> Void {
        if let index = branchOffices.firstIndex(of: office) {
            let removed = branchOffices.remove(at: index)
            removed.removeVehicle(self)
        }
    }
    
    func addRental(_ rental: Rental) -> Void {
        if !rentals.contains(rental) {
            rentals.append(rental)
            rental.setVehicle(self)
        }
    }
    
    func removeRental(_ rental: Rental) -> Void {
        if let index = rentals.firstIndex(of: rental) {
            let removed = rentals.remove(at: index)
            removed.invalidate()
        }
    }
}
