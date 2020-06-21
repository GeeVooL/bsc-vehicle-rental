//
//  Vehicle.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 11/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

@objc
public enum VehicleState: Int32 {
    case available      = 0
    case unavailable    = 1
}

public enum EngineType: CaseIterable {
    case combustion
    case electric
    case hybrid
    
    var name: String { return "\(self)".capitalized }
}

public enum VehicleType: CaseIterable {
    case automobile
    case motorcycle
    
    var name: String { return "\(self)".capitalized }
}

protocol IVehicle {
    var brand: String? { get set }
    var color: String? { get set }
    var model: String? { get set }
    var modelYear: Int32 { get set }
    var pricePerDay: NSDecimalNumber? { get set }
    var state: VehicleState { get set }
    var engineType: EngineType { get }
    var vehicleType: VehicleType { get }
    
    func getAvailableDates() -> [DateInterval]
    func getDetails() -> [String: String]
    func handOver()
    func reclaim()
    func setMotorcycleRole(context: NSManagedObjectContext,
                      hasWindshield: Bool,
                      trunkSizes: [Int32],
                      type: MotorcycleType)
    func setAutomobileRole(context: NSManagedObjectContext,
                           hasAircondition: Bool,
                           numberOfSeats: Int32,
                           trunkSize: Int32)
}

@objc(Vehicle)
public class Vehicle: NSManagedObject, IVehicle {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Vehicle> {
        return NSFetchRequest<Vehicle>(entityName: "Vehicle")
    }
    
    public static var vehicles: [Vehicle] {
        var allVehicles: [Vehicle] = []
        allVehicles.append(contentsOf: CombustionEngineVehicle.all)
        allVehicles.append(contentsOf: ElectricEngineVehicle.all)
        allVehicles.append(contentsOf: HybridVehicle.all)
        return allVehicles
    }
    
    // MARK: - Attributes
    
    @NSManaged var brand: String?
    @NSManaged var color: String?
    @NSManaged var model: String?
    @NSManaged var modelYear: Int32
    @NSManaged var pricePerDay: NSDecimalNumber?
    @NSManaged var state: VehicleState
    @NSManaged var imageName: String?
    
    var engineType: EngineType {
        switch self {
        case is CombustionEngineVehicle:
            return EngineType.combustion
        case is ElectricEngineVehicle:
            return EngineType.electric
        case is HybridVehicle:
            return EngineType.hybrid
        default:
            assertionFailure("Type not supported")
        }
        
        // Silence compilator error
        return EngineType.combustion
    }

    var vehicleType: VehicleType {
        return self.automobile != nil ? VehicleType.automobile : VehicleType.motorcycle
    }
    
    @NSManaged var services: Set<Service>?
    @NSManaged var rentals: Set<Rental>?
    @NSManaged var office: BranchOffice?
    
    @NSManaged var motorcycle: MotorcycleVehicle?
    @NSManaged var automobile: AutomobileVehicle?
    
    // Motorcycle attributes
    var hasWindshield: Bool? {
        self.motorcycle?.hasWindshield
    }
    var trunkSizes: [Int32]? {
        self.motorcycle?.trunkSizes
    }
    var type: MotorcycleType? {
        self.motorcycle?.type
    }
    
    // Automobile attributes
    var hasAircondition: Bool? {
        self.automobile?.hasAircondition
    }
    var numberOfSeats: Int32? {
        self.automobile?.numberOfSeats
    }
    var trunkSize: Int32? {
        self.automobile?.trunkSize
    }

    // MARK: - CoreData helpers
    
    @objc(addServicesObject:)
    @NSManaged public func addToServices(_ value: Service)
    
    @objc(removeServicesObject:)
    @NSManaged public func removeFromServices(_ value: Service)
    
    @objc(addServices:)
    @NSManaged public func addToServices(_ values: Set<Service>)
    
    @objc(removeServices:)
    @NSManaged public func removeFromServices(_ values: Set<Service>)
    
    @objc(addRentalsObject:)
    @NSManaged public func addToRentals(_ value: Rental)
    
    @objc(removeRentalsObject:)
    @NSManaged public func removeFromRentals(_ value: Rental)
    
    @objc(addRentals:)
    @NSManaged public func addToRentals(_ values: Set<Rental>)
    
    @objc(removeRentals:)
    @NSManaged public func removeFromRentals(_ values: Set<Rental>)
    
    // MARK: - Initializers
    
    // Loader initializer
    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    // Automobile initializer
    public init(context: NSManagedObjectContext,
         entityName: String,
         brand: String,
         color: String,
         model: String,
         modelYear: Int32,
         pricePerDay: Decimal,
         imageName: String?,
         hasAircondition: Bool,
         numberOfSeats: Int32,
         trunkSize: Int32
    ) {
        let description = NSEntityDescription.entity(forEntityName: entityName, in: context)!
        super.init(entity: description, insertInto: context)
        
        self.brand = brand
        self.color = color
        self.model = model
        self.modelYear = modelYear
        self.pricePerDay = pricePerDay as NSDecimalNumber
        self.imageName = imageName
        
        setAutomobileRole(context: context,
                          hasAircondition: hasAircondition,
                          numberOfSeats: numberOfSeats,
                          trunkSize: trunkSize)
    }
    
    // Motorcycle initializer
    public init(context: NSManagedObjectContext,
         entityName: String,
         brand: String,
         color: String,
         model: String,
         modelYear: Int32,
         pricePerDay: Decimal,
         imageName: String?,
         hasWindshield: Bool,
         trunkSizes: [Int32],
         type: MotorcycleType
    ) {
        let description = NSEntityDescription.entity(forEntityName: entityName, in: context)!
        super.init(entity: description, insertInto: context)
        
        self.brand = brand
        self.color = color
        self.model = model
        self.modelYear = modelYear
        self.pricePerDay = pricePerDay as NSDecimalNumber
        self.imageName = imageName
        
        setMotorcycleRole(context: context,
                          hasWindshield: hasWindshield,
                          trunkSizes: trunkSizes,
                          type: type)
    }
    
    // MARK: - Helpers
    
    /// Set the motorcycle role to the Vehicle object by creating an associated instance of the MotorcycleVehicle class
    /// - Parameters:
    ///   - context: Managed DB context
    ///   - hasWindshield: Whether the motorcycle has a windshield
    ///   - trunkSizes: The list of the sizes of trunks mounted on the motorcycle
    ///   - type: Whether the vehicle is a motorcycle or a scooter
    public func setMotorcycleRole(context: NSManagedObjectContext,
                           hasWindshield: Bool,
                           trunkSizes: [Int32],
                           type: MotorcycleType
    ) {
        if self.automobile == nil && self.motorcycle == nil {
            self.motorcycle = MotorcycleVehicle(context: context,
                                                hasWindshield: hasWindshield,
                                                trunkSizes: trunkSizes,
                                                type: type)
        }
    }
    
    /// Set the automobile role to the Vehicle object by creating an associated instance of the AutomobileVehicle class
    /// - Parameters:
    ///   - context: Managed DB context
    ///   - hasAircondition: Whether the vehicle has an AC
    ///   - numberOfSeats: The number of available seats
    ///   - trunkSize: The size of the trunk
    public func setAutomobileRole(context: NSManagedObjectContext,
                           hasAircondition: Bool,
                           numberOfSeats: Int32,
                           trunkSize: Int32
    ) {
        if self.automobile == nil && self.motorcycle == nil {
            self.automobile = AutomobileVehicle(context: context,
                                                hasAircondition: hasAircondition,
                                                numberOfSeats: numberOfSeats,
                                                trunkSize: trunkSize)
        }
    }
    
    // MARK: - Business logic
    
    /// Get the dates of available rentals
    /// - Returns: List of available date intervals
    public func getAvailableDates() -> [DateInterval] {
        let day: Double = 24 * 60 * 60
        let month: Double = 30 * day
        
        let firstConsideredDate = Calendar.current.startOfDay(for: Date())
        let lastConsideredDate = Calendar.current.startOfDay(for: Date().addingTimeInterval(month))
        let consideredInterval = DateInterval(start: firstConsideredDate, end: lastConsideredDate)
        
        var availableIntervals = [consideredInterval]
        
        let orderedRentals = rentals!.sorted(by: { $0.rentDate! < $1.rentDate! })
        
        var index = 0
        for rental in orderedRentals {
            let firstUnavailableDate = Calendar.current.startOfDay(for: rental.getRentDate())
            let lastUnavailableDate = Calendar.current.startOfDay(for: rental.getReturnDate())
            
            if !consideredInterval.contains(firstUnavailableDate) && !consideredInterval.contains(lastConsideredDate) {
                continue
            }
            
            let containsFirst = firstUnavailableDate > availableIntervals[index].start
            let containsLast = lastUnavailableDate < availableIntervals[index].end
            let current = availableIntervals.remove(at: index)
            
            if containsFirst {
                availableIntervals.append(DateInterval(start: current.start, end: firstUnavailableDate.addingTimeInterval(-day)))
            }
            
            if containsLast {
                availableIntervals.append(DateInterval(start: lastUnavailableDate.addingTimeInterval(day), end: lastConsideredDate))
            }
            
            if containsFirst && containsLast {
                index += 1
            }
        }
        
        return availableIntervals
    }
    
    /// Get the vehicle details as a dictionary
    /// - Returns: Nothing - this is an abstract method
    public func getDetails() -> [String: String] {
        assertionFailure("This method is abstract")
        return [:]
    }
    
    public func handOver() {
        // TODO(mDevv): Implement me
    }
    
    public func reclaim() {
        // TODO(mDevv): Implement me
    }
    
}
