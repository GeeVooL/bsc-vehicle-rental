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
    private let managedContext: NSManagedObjectContext
    
    init(managedContext: NSManagedObjectContext) {
        self.managedContext = managedContext
    }
    
    func loadAll() {
        Person.load(context: managedContext)
        Customer.load(context: managedContext)
        Customer.fillRenting()
        Employee.load(context: managedContext)
        CustomerServiceEmployee.load(context: managedContext)
        Technician.load(context: managedContext)
        CombustionEngineVehicle.load(context: managedContext)
        ElectricEngineVehicle.load(context: managedContext)
        HybridVehicle.load(context: managedContext)
        Service.load(context: managedContext)
        BranchOffice.load(context: managedContext)
        Rental.load(context: managedContext)
        Invoice.load(context: managedContext)
        InvoiceItem.load(context: managedContext)
    }
    
    func preloadData() {
        
        // Create customer
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let birthDate = dateFormatter.date(from: "23/05/1994")!
        
        let _ = Person(context: managedContext,
                       name: "Edward",
                       surname: "McClient",
                       birthDate: birthDate,
                       address: Address(context: managedContext,
                                        street: "Góralska 512",
                                        city: "Kozia Wólka",
                                        postCode: "05-324",
                                        country: "Poland"),
                       email: "edward.mcclient@gmail.com",
                       phone: "+48660439345",
                       discount: 0.05,
                       registrationDate: Date())
        
        
        // Create branches
        let alpha = BranchOffice(context: managedContext,
                                 name: "Alpha",
                                 garageCapacity: 8,
                                 address: Address(context: managedContext,
                                                  street: "Wolska 12",
                                                  city: "Warszawa",
                                                  postCode: "01-258",
                                                  country: "Poland"))
        
        save(context: managedContext)
        
        let beta = BranchOffice(context: managedContext,
                             name: "Beta",
                             garageCapacity: 12,
                             address: Address(context: managedContext,
                                              street: "Al. Jerozolimskie 216",
                                              city: "Warszawa",
                                              postCode: "02-486",
                                              country: "Poland"))
        
        save(context: managedContext)
        
        // Create vehicles
        let prius = HybridVehicle(context: managedContext,
                                  brand: "Toyota",
                                  color: "Blue",
                                  model: "Prius",
                                  modelYear: 2020,
                                  pricePerDay: Decimal(floatLiteral: 84.99),
                                  imageName: "toyota-prius",
                                  hasAircondition: true,
                                  numberOfSeats: 5,
                                  trunkSize: 502,
                                  batteryCapacity: 9,
                                  chargingTime: 140,
                                  range: 40,
                                  averageFuelConsumption: 4.1,
                                  tankCapacity: 48,
                                  maxSpeedUsingElectricEngine: 120.5,
                                  hybridType: HybridType.plugIn)
        alpha.addToVehicles(prius)
        
        let cooper = ElectricEngineVehicle(context: managedContext,
                                           brand: "Mini",
                                           color: "Red",
                                           model: "Cooper SE",
                                           modelYear: 2019,
                                           pricePerDay: Decimal(floatLiteral: 115.0),
                                           imageName: "mini-cooper-se",
                                           hasAircondition: true,
                                           numberOfSeats: 5,
                                           trunkSize: 160,
                                           batteryCapacity: 32,
                                           chargingTime: 60,
                                           range: 232)
        alpha.addToVehicles(cooper)
        
        let mt09 = CombustionEngineVehicle(context: managedContext,
                                           brand: "Yamaha",
                                           color: "Black",
                                           model: "MT-09",
                                           modelYear: 2017,
                                           pricePerDay: Decimal(floatLiteral: 65.90),
                                           imageName: "yamaha-mt09",
                                           hasWindshield: false,
                                           trunkSizes: [],
                                           type: MotorcycleType.motorcycle,
                                           averageFuelConsumption: 5.5,
                                           tankCapacity: 14)
        beta.addToVehicles(mt09)
        
        self.save(context: managedContext)
    }
    
    private func save(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
}
