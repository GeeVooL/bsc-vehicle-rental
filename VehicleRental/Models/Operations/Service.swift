//
//  Service.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 12/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation

class Service {
    let serviceDate: Date
    let issueDescription: String
    
    init(serviceDate: Date, issueDescription: String) {
        self.serviceDate = serviceDate
        self.issueDescription = issueDescription
    }
}
