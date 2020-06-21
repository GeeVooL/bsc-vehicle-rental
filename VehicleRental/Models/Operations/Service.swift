//
//  Service.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 12/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

@objc(Service)
public class Service: NSManagedObject, Manageable {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Service> {
        return NSFetchRequest<Service>(entityName: "Service")
    }
    
    public static var all: [Service] = []
    
    // MARK: - Attributes
    
    @NSManaged var issueDescription: String?
    @NSManaged var serviceDate: Date?
    
    @NSManaged var technician: Technician?
    @NSManaged var vehicle: Vehicle?
    @NSManaged var invoice: Invoice?
    
    // MARK: - Initializers
    
    // Loader initializer
    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    public init(context: NSManagedObjectContext,
                technician: Technician,
                vehicle: Vehicle,
                serviceDate: Date,
                issueDescription: String
    ) {
        let description = NSEntityDescription.entity(forEntityName: "Service", in: context)!
        super.init(entity: description, insertInto: context)
        addToAll()
        
        self.technician = technician
        self.vehicle = vehicle
        
        self.serviceDate = serviceDate
        self.issueDescription = issueDescription
    }
    
    // MARK: - Business logic
    
    /// Create an Invoice related to this Service
    public func issueInvoice() {
        // TODO(mDevv): Implement me
    }
    
}
