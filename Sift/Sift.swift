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

    //MARK: Functions to read from dictionary

    public func readString(from: [String: Any?]?, key: String) throws -> String {
        return try read(dictionary: from, key: key)
    }

    public func readString(from: [String: Any?]?, key: String, defaultValue: String?) -> String? {
        return read(dictionary: from, key: key, defaultValue: defaultValue)
    }

    public func readStringArray(from: [String: Any?]?, key: String) throws -> [String] {
        return try read(dictionary: from, key: key)
    }

    public func readStringArray(from: [String: Any?]?, key: String, defaultValue: [String]?) -> [String]? {
        return read(dictionary: from, key: key, defaultValue: defaultValue)
    }

    public func readNumber(from: [String: Any?]?, key: String) throws -> NSNumber {
        return try read(dictionary: from, key: key)
    }

    public func readNumber(from: [String: Any?]?, key: String, defaultValue: NSNumber?) -> NSNumber? {
        return read(dictionary: from, key: key, defaultValue: defaultValue)
    }

    public func readNumberArray(from: [String: Any?]?, key: String) throws -> [NSNumber] {
        return try read(dictionary: from, key: key)
    }

    public func readNumberArray(from: [String: Any?]?, key: String, defaultValue: [NSNumber]?) -> [NSNumber]? {
        return read(dictionary: from, key: key, defaultValue: defaultValue)
    }

    public func readDictionary(from: [String: Any?]?, key: String) throws -> [String: Any?] {
        return try read(dictionary: from, key: key)
    }

    public func readDictionary(from: [String: Any?]?, key: String, defaultValue: [String: Any?]?) -> [String: Any?]? {
        return read(dictionary: from, key: key, defaultValue: defaultValue)
    }

    public func readDictionaryArray(from: [String: Any?]?, key: String) throws -> [[String: Any?]] {
        return try read(dictionary: from, key: key)
    }

    public func readDictionaryArray(from: [String: Any?]?, key: String, defaultValue: [[String: Any?]]?) -> [[String: Any?]]? {
        return read(dictionary: from, key: key, defaultValue: defaultValue)
    }

    public func readBool(from: [String: Any?]?, key: String) throws -> Bool {
        return try read(dictionary: from, key: key)
    }

    public func readBool(from: [String: Any?]?, key: String, defaultValue: Bool?) -> Bool? {
        return read(dictionary: from, key: key, defaultValue: defaultValue)
    }

    private func read<T: Any>(dictionary: [String: Any?]?, key: String, defaultValue: T?) -> T? {
        do {
            return try read(dictionary: dictionary, key: key)
        } catch {
            return defaultValue
        }
    }

    private func read<T: Any>(dictionary: [String: Any?]?, key: String) throws -> T {
        guard dictionary != nil else {
            throw SiftError(message: "the map is null")
        }

        if dictionary!.keys.contains(key) {
            if let value = dictionary![key], value != nil {
                return try parseValue(value!)
            } else {
                throw SiftError(message: "the value is null")
            }
        } else {
            throw SiftError(message: "key not found")
        }
    }

    private func parseValue<T: Any>(_ value: Any) throws -> T {
        if value is T {
            return value as! T
        } else {
            throw SiftError(message: "the value type is not the same as the requested one.\nRequested Type: \(type(of: T.self))\nFound: \(type(of: value))")
        }
    }

    //MARK: Functions to read from array

    public func readString(from: [Any?]?, atIndex: Int?) throws -> String {
        return try read(array: from, atIndex: atIndex)
    }

    public func readString(from: [Any?]?, atIndex: Int?, defaultValue: String?) -> String? {
        return read(array: from, atIndex: atIndex, defaultValue: defaultValue)
    }

    public func readNumber(from: [Any?]?, atIndex: Int?) throws -> NSNumber {
        return try read(array: from, atIndex: atIndex)
    }

    public func readNumber(from: [Any?]?, atIndex: Int?, defaultValue: NSNumber?) -> NSNumber? {
        return read(array: from, atIndex: atIndex, defaultValue: defaultValue)
    }

    public func readDictionary(from: [Any?]?, atIndex: Int?) throws -> [String: Any?] {
        return try read(array: from, atIndex: atIndex)
    }

    public func readDictionary(from: [Any?]?, atIndex: Int?, defaultValue: [String: Any?]?) -> [String: Any?]? {
        return read(array: from, atIndex: atIndex, defaultValue: defaultValue)
    }


    private func read<T: Any>(array: [Any?]?, atIndex: Int?, defaultValue: T?) -> T? {
        do {
            return try read(array: array, atIndex: atIndex)
        } catch {
            return defaultValue
        }
    }

    private func read<T: Any>(array: [Any?]?, atIndex: Int?) throws -> T {
        guard let array = array else { throw SiftError(message: "the array is null") }
        
        guard let index = atIndex else { throw SiftError(message: "the index is null") }

        if array.count > index {
            if let value = array[index] {
                return try parseValue(value)
            } else {
                throw SiftError(message: "the value is null")
            }
        } else {
            throw SiftError(message: "index \(index) out of bounds")
        }
    }

}
