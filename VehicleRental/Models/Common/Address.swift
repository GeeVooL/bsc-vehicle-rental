//
//  Address+CoreDataClass.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 14/06/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Address)
public class Address: NSManagedObject {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Address> {
        return NSFetchRequest<Address>(entityName: "Address")
    }
    
    @NSManaged var street: String?
    @NSManaged var city: String?
    @NSManaged var postCode: String?
    @NSManaged var country: String?
    
    @NSManaged private var office: BranchOffice?
    @NSManaged private var person: Person?
    
    init(context: NSManagedObjectContext,
         street: String,
         city: String,
         postCode: String,
         country: String
    ) {
        let description = NSEntityDescription.entity(forEntityName: "Address", in: context)!
        super.init(entity: description, insertInto: context)
        
        self.street = street
        self.city = city
        self.postCode = postCode
        self.country = country
    }
}
