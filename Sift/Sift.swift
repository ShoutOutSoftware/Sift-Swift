//
//  Sift.swift
//  Sift
//
//  Created by Obaid Ahmed Mohammed on 14/11/17.
//  Copyright © 2017 Shoutout Software. All rights reserved.
//

import Foundation

public class Sift {
    
    public init() {
        
    }

    public func readString(from: [String: Any?], key: String) throws -> String {
        return try read(dictionary: from, key: key)
    }
    
    public func readString(from: [String: Any?], key: String, defaultValue: String?) -> String? {
        return read(dictionary: from, key: key, defaultValue: defaultValue)
    }
    
    public func readStringList(from: [String: Any?], key: String) throws -> [String] {
        return try read(dictionary: from, key: key)
    }
    
    public func readStringList(from: [String: Any?], key: String, defaultValue: [String]?) -> [String]? {
        return read(dictionary: from, key: key, defaultValue: defaultValue)
    }
    
    public func readNumber(from: [String: Any?], key: String) throws -> NSNumber {
        return try read(dictionary: from, key: key)
    }
    
    public func readNumber(from: [String: Any?], key: String, defaultValue: NSNumber?) -> NSNumber? {
        return read(dictionary: from, key: key, defaultValue: defaultValue)
    }
    
    public func readNumberList(from: [String: Any?], key: String) throws -> [NSNumber] {
        return try read(dictionary: from, key: key)
    }
    
    public func readNumberList(from: [String: Any?], key: String, defaultValue: [NSNumber]?) -> [NSNumber]? {
        return read(dictionary: from, key: key, defaultValue: defaultValue)
    }
    
    public func readDictionary(from: [String: Any?], key: String) throws -> [String: Any?] {
        return try read(dictionary: from, key: key)
    }
    
    public func readDictionary(from: [String: Any?], key: String, defaultValue: [String: Any?]?) -> [String: Any?]? {
        return read(dictionary: from, key: key, defaultValue: defaultValue)
    }
    
    public func readDictionaryList(from: [String: Any?], key: String) throws -> [[String: Any?]] {
        return try read(dictionary: from, key: key)
    }
    
    public func readDictionaryList(from: [String: Any?], key: String, defaultValue: [[String: Any?]]?) -> [[String: Any?]]? {
        return read(dictionary: from, key: key, defaultValue: defaultValue)
    }
    
    public func readBool(from: [String: Any?], key: String) throws -> Bool {
        return try read(dictionary: from, key: key)
    }
    
    public func readBool(from: [String: Any?], key: String, defaultValue: Bool?) -> Bool? {
        return read(dictionary: from, key: key, defaultValue: defaultValue)
    }

    private func read<T: Any>(dictionary: [String: Any?], key: String, defaultValue: T?) -> T? {
        do {
            return try read(dictionary: dictionary, key: key)
        } catch {
            return defaultValue
        }
    }

    private func read<T: Any>(dictionary: [String: Any?], key: String) throws -> T {
        if dictionary.keys.contains(key) {
            if let value = dictionary[key], value != nil {
                return try parseValue(value)
            } else {
                throw SiftError.NullValue
            }
        } else {
            throw SiftError.KeyNotFound
        }
    }

    private func parseValue<T: Any>(_ value: Any?) throws -> T {
        if value is T {
            return value as! T
        } else {
            throw SiftError.IncompatibleTypes(message: "the value type is not the same as the requested one" +
                                                  "\nRequested Type: \(type(of: T.self))\nFound: \(type(of: value))")
        }
    }

}
