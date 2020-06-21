//
//  Customer.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 11/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

@objc(Customer)
public class Customer: NSManagedObject, Manageable {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Customer> {
        return NSFetchRequest<Customer>(entityName: "Customer")
    }
    
    public static var all: [Customer] = []
    
    // MARK: - Attributes
    
    private static var renting: [Customer] = []
    
    @NSManaged private var discount: Float
    @NSManaged private var registrationDate: Date?
    @NSManaged private var isRenting: Bool
    
    @NSManaged private var person: Person?
    @NSManaged private var rentals: Set<Rental>?

    // MARK: - CoreData helpers
    
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
    
    public init(context: NSManagedObjectContext, person: Person, registrationDate: Date, discount: Float) {
        let description = NSEntityDescription.entity(forEntityName: "Customer", in: context)!
        super.init(entity: description, insertInto: context)
        addToAll()
        
        self.person = person
        
        self.registrationDate = registrationDate
        self.discount = discount
    }
    
    // MARK: - Helpers
    
    public static func fillRenting() {
        for cust in Customer.all {
            if cust.isRenting {
                Customer.renting.append(cust)
            }
        }
    }
    
    public func delete(context: NSManagedObjectContext) {
        self.removeFromAll()
        self.removeFromRenting()
        for rental in rentals! {
            rental.removeFromAll()
        }
                
        context.delete(self)
        
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    // MARK: - Getters and setters
    
    public func getPerson() -> Person {
        return self.person!
    }
    
    public func getRentals() -> Set<Rental> {
        return self.rentals!
    }
    
    public func getRegistrationDate() -> Date {
        return self.registrationDate!
    }
    
    public func getDiscount() -> Float {
        return self.discount
    }
    
    public func setDiscount(discount: Float) {
        self.discount = discount
    }
    
    // MARK: - Business logic
    
    /// List all customers that are currently renting a vehicle
    /// - Returns: List of renting customers
    public static func listRentingCustomers() -> [Customer] {
        return renting
    }
    
    /// Create a new vehicle reservation by creating a Rental object related to the vehicle and the customer
    /// - Parameters:
    ///   - context: Managed DB context
    ///   - vehicle: Reserved vehicle
    ///   - startDate: The first day of rental
    ///   - endDate: The last day of rental
    /// - Returns: Unique reservation code related to the created Rental
    public func bookVehicle(context: NSManagedObjectContext, vehicle: Vehicle, startDate: Date, endDate: Date) -> String {
        let uniqueCode = Rental.createUniqueCode()
        
        let _ = Rental(context: context,
                       customer: self,
                       vehicle: vehicle,
                       reservationCode: uniqueCode,
                       rentDate: startDate,
                       returnDate: endDate)
        
        return uniqueCode
    }
    
    /// Add this customer to the list of currently renting ones
    public func addToRenting() {
        self.isRenting = true
        Customer.renting.append(self)
    }
    
    /// Remove this customer from the list of currently renting ones
    public func removeFromRenting() {
        self.isRenting = false
        if let index = Customer.renting.firstIndex(of: self) {
            Customer.renting.remove(at: index)
        }
    }
    
    /// Update customer's personal information in the system
    public func updateInformation() {
        // TODO(mDevv): Implement me
    }
    
}
