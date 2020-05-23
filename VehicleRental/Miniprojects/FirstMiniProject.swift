//
//  FirstMiniProject.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 19/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

class FirstMiniProject {
    let persistentContainer: NSPersistentContainer
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }
    
    func checkExampleExtensions() {
        // Customer
        Customer.all.print()
        let customer = Customer(name: "John",
                         surname: "Appleseed",
                         birthDate: Date(),
                         address: Address(
                            street: "Main Street",
                            city: "New York City",
                            zipCode: "10010",
                            country: "USA"),
                         email: "john.appleseed@icloud.com",
                         phone: "202-555-0112",
                         registrationDate: Date(),
                         discount: 0.02
        )
        Customer.all.print()
        Customer.all.remove(object: customer)
        Customer.all.print()
        
        // ElectricEngineVehicle
        ElectricEngineVehicle.all.print()
        let electric = ElectricEngineVehicle(
            registrationNumber: "WX12312",
            brand: "Tesla",
            model: "Model S",
            modelYear: 2019,
            colour: "Obsidian",
            pricePerDay: Decimal(floatLiteral: 30.5),
            batteryCapacity: 85.0,
            chargingTime: 75,
            range: 426
        )
        ElectricEngineVehicle.all.print()
        ElectricEngineVehicle.all.remove(object: electric)
        ElectricEngineVehicle.all.print()
    }
    
    func checkPersistentExtension() {
        let context = persistentContainer.viewContext
        
        // Rerun the app to see the results
        BranchOffice.all.print()
        let office = BranchOffice(
            address: Address(
                street: "W 42nd St 12",
                city: "New York City",
                zipCode: "10036",
                country: "USA"),
            garageCapacity: 6
        )
        BranchOffice.all.print()
        
        // Save to DB
        do {
            BranchOffice.all.save(in: persistentContainer)
            try context.save()
        } catch let error {
            print(error)
            return
        }
        
        // Delete in-memory instance
        BranchOffice.all.remove(object: office)
        BranchOffice.all.print()
        
        // Load all instances saved in the DB
        BranchOffice.all.load(from: persistentContainer)
        BranchOffice.all.print()
    }
    
    func checkStructProperty() {
        // Create a custom complex property
        let exampleAddress = Address(
            street: "Wiejska 4",
            city: "Warsaw",
            zipCode: "00-902",
            country: "Poland"
        )
        
        // Create a build-in complex property
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: "2019-12-30 12:00:00") ?? Date()
        
        // Set it
        let technician = Technician(
            name: "Jan",
            surname: "Kowalski",
            birthDate: Date(),
            address: exampleAddress,
            email: "jan.kowalski@sejm.gov.pl",
            phone: "700800100",
            employmentDate: date,
            baseSalary: 3212.54,
            specialization: Technician.Specialization.electronics
        )
        
        print(String(describing: technician))
    }
    
    func checkOptionalProperty() {
        // TODO: Implement me
    }
    
    func checkRepetitiveProperty() {
        let motorcycle = MotorcycleVehicle(
            registrationNumber: "WW23XA",
            brand: "Yamaha",
            model: "MT-09",
            modelYear: 2018,
            colour: "Black",
            pricePerDay: 100,
            type: MotorcycleVehicle.MotorcycleType.motorbike,
            hasWindshield: false,
            trunkSizes: [10]
        )
        
        print(String(describing: motorcycle))
        motorcycle.trunkSizes.append(contentsOf: [35, 35])
        print(String(describing: motorcycle))
    }
    
    func checkClassProperty() {
        print(InvoiceItem.vatTax)
    }
    
    func checkComputedProperty() {
        // TODO: Implement me
    }
    
    func checkClassMethod() {
        // TODO: Implement me
    }
    
    func checkOverloading() {
        // TODO: Implement me
    }
    
    func checkOverriding() {
        let customerServiceEmp = CustomerServiceEmployee(
            name: "John",
            surname: "Appleseed",
            birthDate: Date(),
            address: Address(
                street: "Wiejska 4",
                city: "Warsaw",
                zipCode: "00-902",
                country: "Poland"
            ),
            email: "john.appleseed@icloud.com",
            phone: "202-555-0112",
            employmentDate: Date(),
            baseSalary: 2300.0,
            totalOrders: 10
        )
        
        let technician = Technician(
            name: "John",
            surname: "Appleseed",
            birthDate: Date(),
            address: Address(
                street: "Wiejska 4",
                city: "Warsaw",
                zipCode: "00-902",
                country: "Poland"
            ),
            email: "john.appleseed@icloud.com",
            phone: "202-555-0112",
            employmentDate: Date(),
            baseSalary: 2300.0,
            specialization: Technician.Specialization.electronics
        )
        
        print(customerServiceEmp.calculateSalary())
        print(technician.calculateSalary())
    }
}
