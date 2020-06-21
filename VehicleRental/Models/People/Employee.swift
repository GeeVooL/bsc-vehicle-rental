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
    
    @NSManaged var baseSalary: NSDecimalNumber?
    @NSManaged var employmentDate: Date?
    
    @NSManaged var person: Person?
    @NSManaged var customerServiceEmployee: CustomerServiceEmployee?
    @NSManaged var technician: Technician?
    @NSManaged var offices: Set<BranchOffice>?
    
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
         baseSalary: Decimal,
         employmentDate: Date
    ) {
        let description = NSEntityDescription.entity(forEntityName: "Employee", in: context)!
        super.init(entity: description, insertInto: context)
        addToAll()
        
        self.baseSalary = baseSalary as NSDecimalNumber
        self.employmentDate = employmentDate
    }
        
    // MARK: - Helpers
    
    public func delete(context: NSManagedObjectContext) {
        self.removeFromAll()
        if let technician = self.technician {
            technician.removeFromAll()
            for service in technician.services! {
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
        
        self.customerServiceEmployee = CustomerServiceEmployee(context: context, totalOrders: totalOrders)
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
        
        self.technician = Technician(context: context, specialization: specialization)
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
