//
//  AutomobileVehicle.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 12/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

@objc(AutomobileVehicle)
public class AutomobileVehicle: NSManagedObject {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<AutomobileVehicle> {
        return NSFetchRequest<AutomobileVehicle>(entityName: "AutomobileVehicle")
    }
    
    // MARK: - Attributes
    
    @NSManaged var hasAircondition: Bool
    @NSManaged var numberOfSeats: Int32
    @NSManaged var trunkSize: Int32
    
    @NSManaged private var vehicle: Vehicle?
    
    // MARK: - Initializers
    
    // Loader initializer
    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    init(context: NSManagedObjectContext,
         hasAircondition: Bool,
         numberOfSeats: Int32,
         trunkSize: Int32
    ) {
        let description = NSEntityDescription.entity(forEntityName: "AutomobileVehicle", in: context)!
        super.init(entity: description, insertInto: context)
        
        self.hasAircondition = hasAircondition
        self.numberOfSeats = numberOfSeats
        self.trunkSize = trunkSize
    }
    
}
