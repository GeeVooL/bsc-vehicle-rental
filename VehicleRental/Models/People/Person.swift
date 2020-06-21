//
//  Person.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 11/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

@objc(Person)
public class Person: NSManagedObject, Manageable {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }
    
    public static var all: [Person] = []
    
    // MARK: - Attributes
    
    @NSManaged private var birthDate: Date?
    @NSManaged private var email: String?
    @NSManaged private var name: String?
    @NSManaged private var phone: String?
    @NSManaged private var surname: String?
    
    @NSManaged private var customer: Customer?
    @NSManaged private var employee: Employee?
    @NSManaged private var address: Address?
    
    // MARK: - Initializers
    
    // Loader initializer
    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    // Customer init
    public init(context: NSManagedObjectContext,
         name: String,
         surname: String,
         birthDate: Date,
         address: Address,
         email: String,
         phone: String,
         discount: Float,
         registrationDate: Date
    ) {
        let description = NSEntityDescription.entity(forEntityName: "Person", in: context)!
        super.init(entity: description, insertInto: context)
        addToAll()
        
        self.name = name
        self.surname = surname
        self.birthDate = birthDate
        self.address = address
        self.email = email
        self.phone = phone
        
        addCustomerRole(context: context, discount: discount, registrationDate: registrationDate)
    }
    
    // Employee init
    public init(context: NSManagedObjectContext,public
         name: String,
         surname: String,
         birthDate: Date,
         address: Address,
         email: String,
         phone: String,
         baseSalary: Decimal,
         employmentDate: Date
    ) {
        let description = NSEntityDescription.entity(forEntityName: "Person", in: context)!
        super.init(entity: description, insertInto: context)
        addToAll()
        
        self.name = name
        self.surname = surname
        self.birthDate = birthDate
        self.address = address
        self.email = email
        self.phone = phone
        
        addEmployeeRole(context: context, baseSalary: baseSalary, employmentDate: employmentDate)
    }
    
    // MARK: - Helpers
    
    public func delete(context: NSManagedObjectContext) {
        self.removeFromAll()
        if let customer = self.customer {
            customer.removeFromAll()
            customer.removeFromRenting()
            for rental in customer.getRentals() {
                rental.removeFromAll()
            }
        }
        self.employee?.removeFromAll()
        if let technician = self.employee?.getTechnician()! {
            technician.removeFromAll()
            for service in technician.getServices() {
                service.removeFromAll()
            }
        }
        self.employee?.getCustomerServiceEmployee()?.removeFromAll()
        
        context.delete(self)
        
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    /// Add customer role to the Person object by creating an associated instance of Customer class
    /// - Parameters:
    ///   - context: Managed DB context
    ///   - discount: Granted customer's discount in decimal notation of percents
    ///   - registrationDate: The date of customer's registration in the system
    public func addCustomerRole(context: NSManagedObjectContext, discount: Float, registrationDate: Date) {
        if customer == nil {
            let _ = Customer(context: context, person: self, registrationDate: registrationDate, discount: discount)
        }
    }
    
    /// Add employee role to the Person object by creating an associated instance of Employee class
    /// - Parameters:
    ///   - context: Managed DB context
    ///   - baseSalary: Base salary of employee
    ///   - employmentDate: The date the employee was hired
    public func addEmployeeRole(context: NSManagedObjectContext, baseSalary: Decimal, employmentDate: Date) {
        if employee == nil {
            let _ = Employee(context: context, person: self, baseSalary: baseSalary, employmentDate: employmentDate)
        }
    }
    
    // MARK: - Getters and setters
    
    public func getName() -> String {
        return self.name!
    }
    
    public func getSurname() -> String {
        return self.surname!
    }
    
    public func getBirthDate() -> Date {
        return self.birthDate!
    }
    
    public func getAddress() -> Address {
        return self.address!
    }
    
    public func setAddress(address: Address) {
        self.address = address
    }
    
    public func getEmail() -> String {
        return self.email!
    }
    
    public func setEmail(email: String) {
        self.email = email
    }
    
    public func getPhone() -> String {
        return self.phone!
    }
    
    public func setPhone(phone: String) {
        self.phone = phone
    }
    
    public func getCustomer() -> Customer? {
        return self.customer
    }
    
    public func getEmployee() -> Employee? {
        return self.employee
    }
}
