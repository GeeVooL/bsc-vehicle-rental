//
//  HybridVehicle.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 12/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

@objc
public enum HybridType: Int32 {
    case mild   = 0
    case full   = 1
    case plugIn = 2
    
    var name: String {
        switch self {
        case .mild: return "Mild"
        case .full: return "Full"
        case .plugIn: return "Plug-in"
        }
    }
}

@objc(HybridVehicle)
public class HybridVehicle: Vehicle, IElectricEngineVehicle, ICombustionEngineVehicle, Manageable {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<HybridVehicle> {
        return NSFetchRequest<HybridVehicle>(entityName: "HybridVehicle")
    }
    
    public static var all: [HybridVehicle] = []
    
    // MARK: - Attributes
    
    @NSManaged var maxSpeedUsingElectricEngine: Float
    @NSManaged var hybridType: HybridType
    
    @NSManaged var averageFuelConsumption: Float
    @NSManaged var range: Int32
    @NSManaged var chargingTime: Int32
    @NSManaged var batteryCapacity: Int32
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
                batteryCapacity: Int32,
                chargingTime: Int32,
                range: Int32,
                averageFuelConsumption: Float,
                tankCapacity: Int32,
                maxSpeedUsingElectricEngine: Float,
                hybridType: HybridType
    ) {
        super.init(context: context,
                   entityName: "HybridVehicle",
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
        self.batteryCapacity = batteryCapacity
        self.chargingTime = chargingTime
        self.range = range
        
        self.maxSpeedUsingElectricEngine = maxSpeedUsingElectricEngine
        self.hybridType = hybridType
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
                batteryCapacity: Int32,
                chargingTime: Int32,
                range: Int32,
                averageFuelConsumption: Float,
                tankCapacity: Int32,
                maxSpeedUsingElectricEngine: Float,
                hybridType: HybridType
    ) {
        super.init(context: context,
                   entityName: "HybridVehicle",
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
        self.batteryCapacity = batteryCapacity
        self.chargingTime = chargingTime
        self.range = range
        
        self.maxSpeedUsingElectricEngine = maxSpeedUsingElectricEngine
        self.hybridType = hybridType
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
    /// - Returns: The details of hybrid vehicle
    public override func getDetails() -> [String: String] {
        if self.motorcycle != nil {
            var sizesStr = ""
            if (trunkSizes!.count == 0) {
                sizesStr = "N/A"
            } else {
                for size in trunkSizes! {
                    sizesStr.append("\(size)L, ")
                }
                sizesStr = sizesStr.trimmingCharacters(in: .whitespaces)
            }
            
            return [
                "Windshield": self.hasWindshield! ? "Yes" : "No",
                "Trunk sizes": sizesStr,
                "Type": self.type!.name,
                "Average fuel consumption": "\(self.averageFuelConsumption) L/100km",
                "Tank capacity": "\(self.tankCapacity) L",
                "Battery capacity": "\(self.batteryCapacity) kWh",
                "Charging time": "\(self.chargingTime) minutes",
                "Range on electric engine": "\(self.range) km",
                "Max speed on electric engine": "\(self.maxSpeedUsingElectricEngine) km/h",
                "Type of hybrid": self.hybridType.name
            ]
        } else if self.automobile != nil {
            return [
                "Aircondition": self.hasAircondition! ? "Yes" : "No",
                "Number of seats": "\(self.numberOfSeats!)",
                "Trunk size": "\(self.trunkSize!) L",
                "Average fuel consumption": "\(self.averageFuelConsumption) L/100km",
                "Tank capacity": "\(self.tankCapacity) L",
                "Battery capacity": "\(self.batteryCapacity) kWh",
                "Charging time": "\(self.chargingTime) minutes",
                "Range on electric engine": "\(self.range) km",
                "Max speed on electric engine": "\(self.maxSpeedUsingElectricEngine) km/h",
                "Type of hybrid": self.hybridType.name
            ]
        }
        
        return [:]
    }
    
}
