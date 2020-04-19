//
//  Extension.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 12/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation
import CoreData

class ClassExtension<T> {
    var objects = [T]()
    
    func add(object: T) {
        objects.append(object)
    }
    
    func remove(object: T) {
        objects.removeAll(where: { $0 as AnyObject === object as AnyObject })
    }
    
    func print() {
        Swift.print("Extent of type \(String(describing: T.self)) (count: \(objects.count)):")
        for object in objects {
            Swift.print("\t\(String(describing: object))")
        }
    }
}

protocol IncludingExtension: DescriptiveStringConvertible {
    associatedtype ExtendableType
    static var all: ClassExtension<ExtendableType> { get set }
}
