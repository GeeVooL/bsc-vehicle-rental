//
//  PersistenceManager.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 19/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

class PersistenceManager {
    private let persistentContainer: NSPersistentContainer
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }
    
    func saveAll() {
        Customer.all.save(in: persistentContainer)
        CustomerServiceEmployee.all.save(in: persistentContainer)
        Technician.all.save(in: persistentContainer)
        CombustionEngineVehicle.all.save(in: persistentContainer)
        ElectricEngineVehicle.all.save(in: persistentContainer)
        HybridVehicle.all.save(in: persistentContainer)
        MotorcycleVehicle.all.save(in: persistentContainer)
        AutomobileVehicle.all.save(in: persistentContainer)
        Service.all.save(in: persistentContainer)
        BranchOffice.all.save(in: persistentContainer)
        Rental.all.save(in: persistentContainer)
        Invoice.all.save(in: persistentContainer)
        InvoiceItem.all.save(in: persistentContainer)
    }
    
    func loadAll() {
        Customer.all.load(from: persistentContainer)
        CustomerServiceEmployee.all.load(from: persistentContainer)
        Technician.all.load(from: persistentContainer)
        CombustionEngineVehicle.all.load(from: persistentContainer)
        ElectricEngineVehicle.all.load(from: persistentContainer)
        HybridVehicle.all.load(from: persistentContainer)
        MotorcycleVehicle.all.load(from: persistentContainer)
        AutomobileVehicle.all.load(from: persistentContainer)
        Service.all.load(from: persistentContainer)
        BranchOffice.all.load(from: persistentContainer)
        Rental.all.load(from: persistentContainer)
        Invoice.all.load(from: persistentContainer)
        InvoiceItem.all.load(from: persistentContainer)
    }
}
