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
    
    static let bonusPerOrder: Float = 0.05
    @NSManaged var totalOrders: Int32
    
    @NSManaged var employee: Employee?
    
    var totalBonus: Decimal {
        employee!.baseSalary! as Decimal * Decimal(Double(CustomerServiceEmployee.bonusPerOrder)) * Decimal(totalOrders)
    }
    
    // MARK: - Initializers
    
    // Loader initializer
    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    public init(context: NSManagedObjectContext,
         totalOrders: Int32) {
        let description = NSEntityDescription.entity(forEntityName: "CustomerServiceEmployee", in: context)!
        super.init(entity: description, insertInto: context)
        addToAll()
        
        self.totalOrders = totalOrders
    }
    
    // MARK: - Business logic
    
    /// Calculate the salary of this employee increased by the bonus
    /// - Returns: Decimal total salary value
    public func calculateSalary() -> Decimal { employee!.baseSalary! as Decimal + totalBonus }
}
