//
//  FirstMiniProject.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 19/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

class SecondMiniProject {
    func checkStandardAssociation() {
        let exampleAddress = Address(
            street: "Wiejska 4",
            city: "Warsaw",
            zipCode: "00-902",
            country: "Poland"
        )
        
        let technician = Technician(
            name: "Jan",
            surname: "Kowalski",
            birthDate: Date(),
            address: exampleAddress,
            email: "jan.kowalski@sejm.gov.pl",
            phone: "700800100",
            employmentDate: Date(),
            baseSalary: 3212.54,
            specialization: Technician.Specialization.electronics
        )
        
        let branchA = BranchOffice(address: exampleAddress, garageCapacity: 123)
        
        let branchB = BranchOffice(address: exampleAddress, garageCapacity: 321)
        
        branchA.addEmployee(technician)
        branchB.addEmployee(technician)
        
        print(String(describing: technician))
    }
    
    func checkQualifiedAssociation() {
        let exampleAddress = Address(
            street: "Wiejska 4",
            city: "Warsaw",
            zipCode: "00-902",
            country: "Poland"
        )
        
        let branch = BranchOffice(address: exampleAddress, garageCapacity: 123)
        
        let vehicleA = ElectricEngineVehicle(
            registrationNumber: "WW12345",
            brand: "Smart",
            model: "Fortwo",
            modelYear: 2019,
            colour: "Pink",
            pricePerDay: Decimal(150),
            batteryCapacity: 6.5,
            chargingTime: 45,
            range: 155
        )
        
        let vehicleB = CombustionEngineVehicle(
            registrationNumber: "WW34212",
            brand: "BMW",
            model: "e36",
            modelYear: 1990,
            colour: "Yellow",
            pricePerDay: Decimal(250),
            averageFuelConsumption: 13.5,
            tankCapacity: 50.6
        )
        
        branch.addVehicle(vehicleA)
        branch.addVehicle(vehicleB)
        
        var fetched = branch.getVehicle("WW12345")
        print(fetched as AnyObject === vehicleA as AnyObject)
        print(String(describing: fetched))
        
        fetched = branch.getVehicle("WW34212")
        print(fetched as AnyObject === vehicleB as AnyObject)
        print(String(describing: fetched))
    }
    
    func checkAttributedAssociation() {
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
        
        let vehicleA = ElectricEngineVehicle(
            registrationNumber: "WW12345",
            brand: "Smart",
            model: "Fortwo",
            modelYear: 2019,
            colour: "Pink",
            pricePerDay: Decimal(150),
            batteryCapacity: 6.5,
            chargingTime: 45,
            range: 155
        )
        
        let vehicleB = CombustionEngineVehicle(
            registrationNumber: "WW34212",
            brand: "BMW",
            model: "e36",
            modelYear: 1990,
            colour: "Yellow",
            pricePerDay: Decimal(250),
            averageFuelConsumption: 13.5,
            tankCapacity: 50.6
        )
        
        let rentalA = Rental(customer: customer, vehicle: vehicleA, rentDate: Date(), plannedReturnDate: Date())
        let rentalB = Rental(customer: customer, vehicle: vehicleB, rentDate: Date(), plannedReturnDate: Date())
        
        print("Vehicle rentals")
        print(vehicleA.rentals)
        print(vehicleB.rentals)
        
        print("Rental A")
        print(rentalA.customer as Any)
        print(rentalA.vehicle as Any)
        
        print("Rental B")
        print(rentalB.customer as Any)
        print(rentalB.vehicle as Any)
        
        customer.removeRental(rentalB)
        
        print("Rental B - invalidated")
        print(rentalB.customer as Any)
        print(rentalB.vehicle as Any)
        
        print("Vehicle B - no rental")
        print(vehicleB.rentals)
    }
    
    func checkComposition() {
        let invoice = Invoice(id: 20200012)
        
        print("Create invoice")
        print(String(describing: invoice))
        
        print("Add items - indirect creation")
        let itemA = InvoiceItem.create(invoice: invoice, name: "Pillow", netPrice: Decimal(floatLiteral: 13.49))
        let itemB = InvoiceItem.create(invoice: invoice, name: "Box", netPrice: Decimal(floatLiteral: 4.79))
        let itemC = InvoiceItem.create(invoice: invoice, name: "Toothbrush", netPrice: Decimal(floatLiteral: 3.59))
        print(itemA as Any)
        print(itemB as Any)
        print(itemC as Any)
        print(invoice)
        
        print("Check uniqueness - the part is exclusive to the one totality")
        let invoiceB = Invoice(id: 20200013)
        let result = invoiceB.addItem(itemA!)
        print(result)
        
        print("Check lifetime - parts should be invalidated along with the parent")
        print(itemA!.isValid)
        print(itemB!.isValid)
        print(itemC!.isValid)
        invoice.invalidate()
        print(itemA!.isValid)
        print(itemB!.isValid)
        print(itemC!.isValid)
    }
}
