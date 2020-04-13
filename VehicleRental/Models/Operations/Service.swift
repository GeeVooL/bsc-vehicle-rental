//
//  Service.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 12/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation

final class Service: IncludingExtension {
    static var all = ClassExtension<Service>()
    
    let serviceDate: Date
    let issueDescription: String
    
    init(serviceDate: Date, issueDescription: String) {
        self.serviceDate = serviceDate
        self.issueDescription = issueDescription
        Service.all.add(object: self)
    }
    
    deinit {
        Service.all.remove(object: self)
    }
}
