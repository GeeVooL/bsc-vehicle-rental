//
//  WeakObject.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 22/05/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

class WeakObject<T: AnyObject>: Equatable {
    weak var object: T?
    init(object: T) {
        self.object = object
    }
    
    static func == (lhs: WeakObject<T>, rhs: WeakObject<T>) -> Bool {
        return lhs.object === rhs.object
    }
}

class WeakObjectArray<T: AnyObject> {
    var objects: Array<WeakObject<T>>
    
    init() {
        self.objects = Array<WeakObject<T>>([])
    }
    
    init(objects: [T]) {
        self.objects = Array<WeakObject<T>>(objects.map { WeakObject(object: $0) })
    }
    
    var allObjects: [T] {
        return objects.compactMap { $0.object }
    }
    
    func contains(_ object: T) -> Bool {
        return self.objects.contains(WeakObject(object: object))
    }
    
    func addObject(_ object: T) {
        self.objects.append(WeakObject(object: object))
    }
    
    func addObjects(_ objects: [T]) {
        self.objects.append(contentsOf: (objects.map { WeakObject(object: $0) }))
    }
}
