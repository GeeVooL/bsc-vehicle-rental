//
//  MotorcycleVehicle.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 12/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

@objc
public enum MotorcycleType: Int32 {
    case motorcycle = 0
    case scooter    = 1
    
    var name: String {
        switch self {
        case .motorcycle: return "Motorcycle"
        case .scooter: return "Scooter"
        }
    }
}

@objc(MotorcycleVehicle)
public class MotorcycleVehicle: NSManagedObject {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MotorcycleVehicle> {
        return NSFetchRequest<MotorcycleVehicle>(entityName: "MotorcycleVehicle")
    }
    
    // MARK: - Attributes
    
    @NSManaged var hasWindshield: Bool
    @NSManaged var trunkSizes: [Int32]?
    @NSManaged var type: MotorcycleType
    
    @NSManaged private var vehicle: Vehicle?
    
    // MARK: - Initializers
    
    // Loader initializer
    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    init(context: NSManagedObjectContext,
         hasWindshield: Bool,
         trunkSizes: [Int32],
         type: MotorcycleType
    ) {
        let description = NSEntityDescription.entity(forEntityName: "MotorcycleVehicle", in: context)!
        super.init(entity: description, insertInto: context)
        
        self.hasWindshield = hasWindshield
        self.trunkSizes = trunkSizes
        self.type = type
    }

}
