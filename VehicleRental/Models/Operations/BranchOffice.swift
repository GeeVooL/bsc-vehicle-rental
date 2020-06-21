//
//  BranchOffice.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 12/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

@objc(BranchOffice)
public class BranchOffice: NSManagedObject, Manageable {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<BranchOffice> {
        return NSFetchRequest<BranchOffice>(entityName: "BranchOffice")
    }
    
    public static var all: [BranchOffice] = []
    
    // MARK: - Attributes
    
    @NSManaged var garageCapacity: Int32
    @NSManaged var name: String?
    @NSManaged var address: Address?
    
    @NSManaged var employees: Set<Employee>?
    @NSManaged var vehicles: Set<Vehicle>?
    
    // MARK: - CoreData helpers
    
    @objc(addEmployeesObject:)
    @NSManaged public func addToEmployees(_ value: Employee)
    
    @objc(removeEmployeesObject:)
    @NSManaged public func removeFromEmployees(_ value: Employee)
    
    @objc(addEmployees:)
    @NSManaged public func addToEmployees(_ values: Set<Employee>)
    
    @objc(removeEmployees:)
    @NSManaged public func removeFromEmployees(_ values: Set<Employee>)
    
    @objc(addVehiclesObject:)
    @NSManaged public func addToVehicles(_ value: Vehicle)
    
    @objc(removeVehiclesObject:)
    @NSManaged public func removeFromVehicles(_ value: Vehicle)
    
    @objc(addVehicles:)
    @NSManaged public func addToVehicles(_ values: Set<Vehicle>)
    
    @objc(removeVehicles:)
    @NSManaged public func removeFromVehicles(_ values: Set<Vehicle>)
    
    // MARK: - Initializers
    
    // Loader initializer
    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    public init(context: NSManagedObjectContext,
                name: String,
                garageCapacity: Int32,
                address: Address
    ) {
        let description = NSEntityDescription.entity(forEntityName: "BranchOffice", in: context)!
        super.init(entity: description, insertInto: context)
        addToAll()
        
        self.name = name
        self.garageCapacity = garageCapacity
        self.address = address
    }
    
    // MARK: - Business logic
    
    
    /// Get the list of all branch offices
    /// - Returns: List of branch offices
    public class func listBranchOffices() -> [BranchOffice] {
        return all
    }
    
    
    /// Get all rentals from this branch office in the given time period
    /// - Parameters:
    ///   - startDate: Start date
    ///   - endDate: End date
    /// - Returns: List of rentals for given criteria
    public func listRentals(startDate: Date, endDate: Date) -> [Rental] {
        // TODO(mDevv): Implement me
        return []
    }
    
    /// List all vehicles stored in this branch office
    /// - Returns: The list of vehicles
    public func listVehicles() -> [Vehicle] {
        return Array(vehicles ?? [])
    }
    
    /// List all vehicles stored in this branch office matching the given criteria
    /// - Parameters:
    ///   - engineType: Engine type
    ///   - vehicleType: Vehicle type
    /// - Returns: List of filtered vehicles
    public func listVehicles(engineType: EngineType, vehicleType: VehicleType) -> [Vehicle] {
        let filteredVehicles = self.vehicles?.filter({$0.engineType == engineType && $0.vehicleType == vehicleType})
        return Array(filteredVehicles ?? [])
    }
}
