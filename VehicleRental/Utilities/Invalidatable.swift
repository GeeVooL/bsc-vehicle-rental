//
//  Invalidatable.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 23/05/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation

protocol Invalidatable {
    var isValid: Bool { get set }
    
    func invalidate()
}
