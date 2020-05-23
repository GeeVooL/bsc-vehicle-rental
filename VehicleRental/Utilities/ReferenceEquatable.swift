//
//  ReferenceEquatable.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 23/05/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation

protocol ReferenceEquatable: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool
}

extension ReferenceEquatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs as AnyObject === rhs as AnyObject
    }
}
