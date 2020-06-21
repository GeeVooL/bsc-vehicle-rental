//
//  Rental.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 12/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

@objc
public enum RentalState: Int32 {
    case planned    = 0
    case inProgress = 1
    case done       = 2
}

@objc(Rental)
public class Rental: NSManagedObject, Manageable {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Rental> {
        return NSFetchRequest<Rental>(entityName: "Rental")
    }
    
    public static var all: [Rental] = []
    
    // MARK: - Attributes
    
    @NSManaged var returnDate: Date?
    @NSManaged var rentDate: Date?
    @NSManaged var reservationCode: String?
    @NSManaged var state: RentalState
    
    @NSManaged var vehicle: Vehicle?
    @NSManaged var customer: Customer?
    @NSManaged var invoice: Invoice?
    
    // MARK: - Initializers
    
    // Loader initializer
    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    public init(context: NSManagedObjectContext,
         customer: Customer,
         vehicle: Vehicle,
         reservationCode: String,
         rentDate: Date,
         returnDate: Date
    ) {
        let description = NSEntityDescription.entity(forEntityName: "Rental", in: context)!
        super.init(entity: description, insertInto: context)
        addToAll()
        
        self.customer = customer
        self.vehicle = vehicle
        
        self.reservationCode = reservationCode
        self.rentDate = rentDate
        self.returnDate = returnDate
        self.state = RentalState.planned
    }
    
    // MARK: - Helpers
    
    private static func generateRandomString() -> String {
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let length = 9
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    private static func checkIfUnique(_ str: String) -> Bool {
        for rental in Rental.all {
            if rental.reservationCode == str {
                return false
            }
        }
        
        return true
    }

    // MARK: - Business logic
    
    /// Create a unique reservation code
    /// - Returns: A unique string with the reservation code
    public static func createUniqueCode() -> String {
        var isUnique = false
        var code = ""
        while !isUnique {
            code = generateRandomString()
            isUnique = checkIfUnique(code)
        }
        
        return code
    }
    
    /// Calculate the total price of the current rental
    /// - Returns: Decimal value with the total rental price
    public func calculatePrice() -> Decimal {
        // TODO(mDevv): Implement me
        return 0;
    }
    
    /// Create an invoice for this rental
    public func issueInvoice() {
        // TODO(mDevv): Implement me
    }
    
    
    /// Get the first day of the rental
    /// - Returns: Start date of the rental
    public func getRentDate() -> Date {
        return rentDate!
    }

    /// Get the last day of the rental
    /// - Returns: End date of the rental
    public func getReturnDate() -> Date {
        return returnDate!
    }
    
    
    /// Increment the return date in case the customer is late
    public func incrementReturnDate() {
        // TODO(mDevv): Implement me
    }
    
}
