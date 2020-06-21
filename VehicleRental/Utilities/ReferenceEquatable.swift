//
//  ReferenceEquatable.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 23/05/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation

public protocol ReferenceEquatable: Equatable {
    
    /// Compare two object using their references
    /// - Parameters:
    ///   - lhs: The first object
    ///   - rhs: The seconf object
    static func == (lhs: Self, rhs: Self) -> Bool
}

extension ReferenceEquatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs as AnyObject === rhs as AnyObject
    }
}
