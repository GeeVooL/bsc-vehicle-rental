//
//  ElectricEngineVehicle.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 12/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

protocol IElectricEngineVehicle: IVehicle {
    var batteryCapacity: Int32 { get set }
    var chargingTime: Int32 { get set }
    var range: Int32 { get set }
}

@objc(ElectricEngineVehicle)
public class ElectricEngineVehicle: Vehicle, IElectricEngineVehicle, Manageable {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ElectricEngineVehicle> {
        return NSFetchRequest<ElectricEngineVehicle>(entityName: "ElectricEngineVehicle")
    }
    
    public static var all: [ElectricEngineVehicle] = []
    
    // MARK: - Attributes
    
    @NSManaged var batteryCapacity: Int32
    @NSManaged var chargingTime: Int32
    @NSManaged var range: Int32
    
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
                range: Int32
    ) {
        super.init(context: context,
                   entityName: "ElectricEngineVehicle",
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
        
        self.batteryCapacity = batteryCapacity
        self.chargingTime = chargingTime
        self.range = range
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
                range: Int32
    ) {
        super.init(context: context,
                   entityName: "ElectricEngineVehicle",
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
        
        self.batteryCapacity = batteryCapacity
        self.chargingTime = chargingTime
        self.range = range
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
    /// - Returns: The details of electric engine vehicle
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
                "Battery capacity": "\(self.batteryCapacity) kWh",
                "Charging time": "\(self.chargingTime) minutes",
                "Range": "\(self.range) km",
            ]
        } else if self.automobile != nil {
            return [
                "Aircondition": self.hasAircondition! ? "Yes" : "No",
                "Number of seats": "\(self.numberOfSeats!)",
                "Trunk size": "\(self.trunkSize!) L",
                "Battery capacity": "\(self.batteryCapacity) kWh",
                "Charging time": "\(self.chargingTime) minutes",
                "Range": "\(self.range) km",
            ]
        }
                
        return [:]
    }

}
