//
//  Employee.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 11/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

@objc(Employee)
public class Employee: NSManagedObject, Manageable {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }
    
    public static var all: [Employee] = []
    
    // MARK: - Attributes
    
    @NSManaged private var baseSalary: NSDecimalNumber?
    @NSManaged private var employmentDate: Date?
    
    @NSManaged private var person: Person?
    @NSManaged private var customerServiceEmployee: CustomerServiceEmployee?
    @NSManaged private var technician: Technician?
    @NSManaged private var offices: Set<BranchOffice>?
    
    // MARK: - CoreData helpers
    
    @objc(addOfficesObject:)
    @NSManaged public func addToOffices(_ value: BranchOffice)
    
    @objc(removeOfficesObject:)
    @NSManaged public func removeFromOffices(_ value: BranchOffice)
    
    @objc(addOffices:)
    @NSManaged public func addToOffices(_ values: Set<BranchOffice>)
    
    @objc(removeOffices:)
    @NSManaged public func removeFromOffices(_ values: Set<BranchOffice>)
    
    // MARK: - Initializers
    
    // Loader initializer
    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    public init(context: NSManagedObjectContext,
                person: Person,
                baseSalary: Decimal,
                employmentDate: Date
    ) {
        let description = NSEntityDescription.entity(forEntityName: "Employee", in: context)!
        super.init(entity: description, insertInto: context)
        addToAll()
        
        self.person = person
        
        self.baseSalary = baseSalary as NSDecimalNumber
        self.employmentDate = employmentDate
    }
    
    // MARK: - Helpers
    
    public func delete(context: NSManagedObjectContext) {
        self.removeFromAll()
        if let technician = self.technician {
            technician.removeFromAll()
            for service in technician.getServices() {
                service.removeFromAll()
            }
        }
        self.customerServiceEmployee?.removeFromAll()
        
        context.delete(self)
        
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    /// Add customer service employee role to the Employee object by creating an associated instance of CustomerServiceEmployee class
    /// - Parameters:
    ///   - context: Managed DB context
    ///   - totalOrders: Number of total orders processed by this employee in the current month
    public func setCustomerServiceRole(context: NSManagedObjectContext, totalOrders: Int32) {
        if (self.customerServiceEmployee != nil) {
            return
        }
        
        if (self.technician != nil) {
            self.technician?.delete(context: context)
        }
        
        let _ = CustomerServiceEmployee(context: context, employee: self, totalOrders: totalOrders)
    }
    
    /// Add technician role to the Employee object by creating an associated instance of Technician class
    /// - Parameters:
    ///   - context: Managed DB context
    ///   - specialization: Technician's specialization
    public func setTechnicianRole(context: NSManagedObjectContext, specialization: TechnicianSpecialization) {
        if (self.technician != nil) {
            return
        }
        
        if (self.customerServiceEmployee != nil) {
            self.customerServiceEmployee?.delete(context: context)
        }
        
        let _ = Technician(context: context, employee: self, specialization: specialization)
    }
    
    // MARK: - Getters and setters
    
    public func getPerson() -> Person {
        return self.person!
    }
    
    public func getOffices() -> Set<BranchOffice> {
        return self.offices!
    }
    
    public func getCustomerServiceEmployee() -> CustomerServiceEmployee? {
        return self.customerServiceEmployee
    }
    
    public func getTechnician() -> Technician? {
        return self.technician
    }
    
    public func getBaseSalary() -> Decimal {
        return self.baseSalary! as Decimal
    }
    
    public func setBaseSalary(baseSalary: Decimal) {
        self.baseSalary = baseSalary as NSDecimalNumber
    }
    
    public func getEmploymentDate() -> Date {
        return self.employmentDate!
    }
    
    // MARK: - Business logic
    
    /// Calculate the salary of the employee basing on his current role
    /// - Returns: Decimal value of the calculated salary
    public func calculateSalary() -> Decimal {
        if self.customerServiceEmployee != nil {
            return (self.customerServiceEmployee?.calculateSalary())!
        }
        
        return baseSalary! as Decimal
    }
    
}
