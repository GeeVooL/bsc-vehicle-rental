//
//  CustomerServiceEmployee.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 11/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

@objc(CustomerServiceEmployee)
public class CustomerServiceEmployee: NSManagedObject, Manageable {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CustomerServiceEmployee> {
        return NSFetchRequest<CustomerServiceEmployee>(entityName: "CustomerServiceEmployee")
    }
    
    public static var all: [CustomerServiceEmployee] = []
    
    // MARK: - Attributes
    
    public static let bonusPerOrder: Float = 0.05
    @NSManaged private var totalOrders: Int32
    
    @NSManaged private var employee: Employee?
    
    private var totalBonus: Decimal {
        employee!.getBaseSalary() as Decimal * Decimal(Double(CustomerServiceEmployee.bonusPerOrder)) * Decimal(totalOrders)
    }
    
    // MARK: - Initializers
    
    // Loader initializer
    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    public init(context: NSManagedObjectContext,
                employee: Employee,
                totalOrders: Int32) {
        let description = NSEntityDescription.entity(forEntityName: "CustomerServiceEmployee", in: context)!
        super.init(entity: description, insertInto: context)
        addToAll()
        
        self.employee = employee
        
        self.totalOrders = totalOrders
    }
    
    // MARK: - Getters and setters
    
    public func getEmployee() -> Employee {
        return self.employee!
    }
    
    public func getTotalOrders() -> Int32 {
        return self.totalOrders
    }
    
    public func setTotalOrders(totalOrders: Int32) {
        self.totalOrders = totalOrders
    }
    
    public func getTotalBonus() -> Decimal {
        return self.totalBonus
    }
    
    // MARK: - Business logic
    
    /// Calculate the salary of this employee increased by the bonus
    /// - Returns: Decimal total salary value
    public func calculateSalary() -> Decimal { employee!.getBaseSalary() as Decimal + totalBonus }
}
