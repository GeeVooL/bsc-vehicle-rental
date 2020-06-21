//
//  CombustionEngineVehicle.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 12/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

protocol ICombustionEngineVehicle: IVehicle {
    var averageFuelConsumption: Float { get set }
    var tankCapacity: Int32 { get set }
}

@objc(CombustionEngineVehicle)
public class CombustionEngineVehicle: Vehicle, ICombustionEngineVehicle, Manageable {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CombustionEngineVehicle> {
        return NSFetchRequest<CombustionEngineVehicle>(entityName: "CombustionEngineVehicle")
    }
    
    public static var all: [CombustionEngineVehicle] = []
    
    // MARK: - Attributes
    
    @NSManaged var averageFuelConsumption: Float
    @NSManaged var tankCapacity: Int32
    
    // MARK: - Initializers
    
    // Automobile variant initializer
    public init(context: NSManagedObjectContext,
                brand: String,
                color: String,
                model: String,
                modelYear: Int32,
                pricePerDay: Decimal,
                imageName: String?,
                hasAircondition: Bool,
                numberOfSeats: Int32,
                trunkSize: Int32,
                averageFuelConsumption: Float,
                tankCapacity: Int32
    ) {
        super.init(context: context,
                   entityName: "CombustionEngineVehicle",
                   brand: brand,
                   color: color,
                   model: model,
                   modelYear: modelYear,
                   pricePerDay: pricePerDay,
                   imageName: imageName,
                   hasAircondition: hasAircondition,
                   numberOfSeats: numberOfSeats,
                   trunkSize: trunkSize)
        addToAll()
        
        self.averageFuelConsumption = averageFuelConsumption
        self.tankCapacity = tankCapacity
    }
    
    // Motorcycle variant initializer
    public init(context: NSManagedObjectContext,
                brand: String,
                color: String,
                model: String,
                modelYear: Int32,
                pricePerDay: Decimal,
                imageName: String?,
                hasWindshield: Bool,
                trunkSizes: [Int32],
                type: MotorcycleType,
                averageFuelConsumption: Float,
                tankCapacity: Int32
    ) {
        super.init(context: context,
                   entityName: "CombustionEngineVehicle",
                   brand: brand,
                   color: color,
                   model: model,
                   modelYear: modelYear,
                   pricePerDay: pricePerDay,
                   imageName: imageName,
                   hasWindshield: hasWindshield,
                   trunkSizes: trunkSizes,
                   type: type)
        addToAll()
        
        self.averageFuelConsumption = averageFuelConsumption
        self.tankCapacity = tankCapacity
    }
    
    // MARK: - Helpers
    
    public func delete(context: NSManagedObjectContext) {
        self.removeFromAll()
        for rental in self.rentals! {
            rental.removeFromAll()
        }
        for service in self.services! {
            service.removeFromAll()
        }
        
        context.delete(self)
        
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    // MARK: - Business logic
    
    /// Get the vehicle details as a dictionary
    /// - Returns: The details of combustion engine vehicle
    public override func getDetails() -> [String: String] {
        if self.motorcycle != nil {
            var sizesStr = ""
            if (trunkSizes!.count == 0) {
                sizesStr = "N/A"
            } else {
                for size in trunkSizes! {
                    sizesStr.append("\(size) L, ")
                }
                sizesStr = sizesStr.trimmingCharacters(in: .whitespaces)
                sizesStr = sizesStr.trimmingCharacters(in: CharacterSet(charactersIn: ","))
            }
            
            return [
                "Windshield": self.hasWindshield! ? "Yes" : "No",
                "Trunk sizes": sizesStr,
                "Type": self.type!.name,
                "Average fuel consumption": "\(self.averageFuelConsumption) L/100km",
                "Tank capacity": "\(self.tankCapacity) L"
            ]
        } else if self.automobile != nil {
            return [
                "Aircondition": self.hasAircondition! ? "Yes" : "No",
                "Number of seats": "\(self.numberOfSeats!)",
                "Trunk size": "\(self.trunkSize!) L",
                "Average fuel consumption": "\(self.averageFuelConsumption) L/100km",
                "Tank capacity": "\(self.tankCapacity) L"
            ]
        }
        
        return [:]
    }
    
}
