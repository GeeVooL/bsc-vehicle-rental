//
//  BranchOffice.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 12/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

final class BranchOffice: IncludingPersistentExtension, Invalidatable, ReferenceEquatable {
    typealias EntityType = BranchOfficeEntity
    
    static var all = PersistentClassExtension<BranchOffice>()
    
    let address: Address
    let garageCapacity: Int32
    
    var isValid: Bool = true
    // Associations
    /// Standard (employee [1..*]---[1..*] branch office)
    private var technicians: [Technician] = []
    private var customerServiceEmployees: [CustomerServiceEmployee] = []
    /// Qualified (vehicle by registration number [*]---[*] branch office)
    private var vehicles: [String: Vehicle] = [:]
    
    
    init(address: Address, garageCapacity: Int32) {
        self.address = address
        self.garageCapacity = garageCapacity
        BranchOffice.all.add(object: self)
    }
    
    required convenience init(from object: NSManagedObject) throws {
        let entity = object as! EntityType
        let addressString = try JSONDecoder().decode(Address.self, from: entity.address!.data(using: .utf8)!)
        self.init(address: addressString, garageCapacity: entity.garageCapacity)
    }
    
    func invalidate() {
        if !isValid { return }
        
        BranchOffice.all.remove(object: self)
        isValid = false
    }
    
    // Standard association
    func addEmployee(_ technician: Technician) {
        if !technicians.contains(technician) {
            technicians.append(technician);
            
            technician.addBranchOffice(self);
        }
    }
    
    func addEmployee(_ customerService: CustomerServiceEmployee) {
        if !customerServiceEmployees.contains(customerService) {
            customerServiceEmployees.append(customerService);
            
            customerService.addBranchOffice(self);
        }
    }
    
    func removeEmployee(_ technician: Technician) {
        if let index = technicians.firstIndex(of: technician) {
            let removed = technicians.remove(at: index);
            removed.removeBranchOffice(self)
        }
    }
    
    func removeEmployee(_ customerService: CustomerServiceEmployee) {
        if let index = customerServiceEmployees.firstIndex(of: customerService) {
            let removed = customerServiceEmployees.remove(at: index);
            removed.removeBranchOffice(self)
        }
    }
    
    // Qualified association
    func addVehicle(_ vehicle: Vehicle) {
        if vehicles[vehicle.registrationNumber] == nil {
            vehicles[vehicle.registrationNumber] = vehicle
            vehicle.addBranchOffice(self)
        }
    }
    
    func removeVehicle(_ vehicle: Vehicle) {
        let removed = vehicles.removeValue(forKey: vehicle.registrationNumber)
        removed?.removeBranchOffice(self)
    }
    
    func getVehicle(_ registrationNumber: String) -> Vehicle? {
        return vehicles[registrationNumber]
    }
    
    func save(context: NSManagedObjectContext) throws {
        let jsonAddress = try JSONEncoder().encode(address)
        let addressString = String(data: jsonAddress, encoding: .utf8)!
        
        let entity = BranchOfficeEntity(context: context)
        entity.address = addressString
        entity.garageCapacity = garageCapacity
        context.insert(entity)
        try context.save()
    }
}
