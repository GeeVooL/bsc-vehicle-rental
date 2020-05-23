
//
//  DescriptingStingConvertible.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 13/04/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation

protocol DescriptiveStringConvertible: CustomStringConvertible {}

extension DescriptiveStringConvertible {
    var description: String {
        let mirror = Mirror(reflecting: self)
        var output = "\(mirror.subjectType) ["
        var isFirst = true
        
        for (property, value) in mirror.children {
            if let property = property {
                if isFirst {
                    isFirst = false
                } else {
                    output += ", "
                }
                
                if value is DescriptiveStringConvertible {
                    output += "\(property): [value]"
                } else if value is Array<DescriptiveStringConvertible> {
                    output += "\(property): [count=\((value as! Array<DescriptiveStringConvertible>).count)]"
                } else {
                    output += "\(property): \(value)"
                }
            }
        }
        
        return "\(output)]"
    }
}
