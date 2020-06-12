//
//  AspectInheritance.swift
//  VehicleRental
//
//  Created by Michał Dziewulski on 07/06/2020.
//  Copyright © 2020 Michał Dziewulski. All rights reserved.
//

import Foundation

enum Endianness {
    case littleEndian
    case bigEndian
}

protocol File: class {
    var name: String { get set }
    var extensionName: String { get set }
    
    var binaryFile: BinaryFile? { get set }
    var textFile: TextFile? { get set }
    var endianness: Endianness? { get }
    var encoding: String? { get }
    func convertEndianness() throws
    func changeEncoding(new: String) throws
    
    func addBinaryFile(endianness: Endianness)
    func addTextFile(encoding: String)
    
    func open()
}

extension File {
    var endianness: Endianness? {
        return self.binaryFile?.endianness
    }
    
    var encoding: String? {
        return self.textFile?.encoding
    }
    
    func convertEndianness() {
        self.binaryFile?.convertEndianness()
    }
    
    func changeEncoding(new: String) {
        self.textFile?.changeEncoding(new: new)
    }
    
    func addBinaryFile(endianness: Endianness) {
        if self.binaryFile == nil && self.textFile == nil {
            self.binaryFile = BinaryFile(endianness: endianness, file: self)
        }
    }
    
    func addTextFile(encoding: String) {
        if self.textFile == nil && self.binaryFile == nil {
            self.textFile = TextFile(encoding: encoding, file: self)
        }
    }
}

// Aspect: file format

struct BinaryFile {
    fileprivate var endianness: Endianness
    
    fileprivate let file: File
    
    func convertEndianness() {
        // Not implemented
    }
}

struct TextFile {
    fileprivate var encoding: String;
    
    fileprivate let file: File
    
    func changeEncoding(new: String) {
        // Not implemented
    }
}

// Aspect: file content

class Image: File {
    var name: String
    var extensionName: String
    var width: UInt
    var height: UInt
    
    var binaryFile: BinaryFile?
    var textFile: TextFile?
    
    init(name: String, extensionName: String, width: UInt, height: UInt, endianness: Endianness) {
        self.name = name
        self.extensionName = extensionName
        self.width = width
        self.height = height
        
        addBinaryFile(endianness: endianness)
    }

    init(name: String, extensionName: String, width: UInt, height: UInt, encoding: String) {
        self.name = name
        self.extensionName = extensionName
        self.width = width
        self.height = height
        
        addTextFile(encoding: encoding)
    }
    
    func open() {
        // Not implemented
    }
}

class SourceCode: File {
    var name: String
    var extensionName: String
    var syntax: String;
    var isInterpreted: Bool
    
    var binaryFile: BinaryFile?
    var textFile: TextFile?
    
    init(name: String, extensionName: String, syntax: String, isInterpreted: Bool, endianness: Endianness) {
        self.name = name
        self.extensionName = extensionName
        self.syntax = syntax
        self.isInterpreted = isInterpreted
        
        addBinaryFile(endianness: endianness)
    }
    
    init(name: String, extensionName: String, syntax: String, isInterpreted: Bool, encoding: String) {
        self.name = name
        self.extensionName = extensionName
        self.syntax = syntax
        self.isInterpreted = isInterpreted
        
        addTextFile(encoding: encoding)
    }
    
    func open() {
        // Not implemented
    }
}

class AudioFile: File {
    var name: String
    var extensionName: String
    var codec: String
    var freq: UInt
    
    var binaryFile: BinaryFile?
    var textFile: TextFile?
    
    internal init(name: String, extensionName: String, codec: String, freq: UInt, endianness: Endianness) {
        self.name = name
        self.extensionName = extensionName
        self.codec = codec
        self.freq = freq
        
        addBinaryFile(endianness: endianness)
    }
    
    internal init(name: String, extensionName: String, codec: String, freq: UInt, encoding: String) {
        self.name = name
        self.extensionName = extensionName
        self.codec = codec
        self.freq = freq
        
        addTextFile(encoding: encoding)
    }
    
    func open() {
        // Not implemented
    }
}
