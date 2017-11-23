//
//  SiftTests.swift
//  SiftTests
//
//  Created by Mohammed Obaid Ahmed on 14/11/17.
//  Copyright © 2017 Shoutout Software. All rights reserved.
//

import XCTest
@testable import Sift

class SiftTests: XCTestCase {

    private let sift = Sift.init()
    private let data: [String: Any?] = ["wrongValue": 2, "nullValue": nil, "correctValue": "some value"]

    func testThrowsErrorIfKeyIsNotFound() {
        XCTAssertThrowsError(try sift.readString(from: data, key: "randomKey")) { error in
            XCTAssertEqual(SiftError.KeyNotFound, error as! SiftError)
        }
    }

    func testThrowsErrorIfValueTypeIsWrong() {
        XCTAssertThrowsError(try sift.readString(from: data, key: "wrongValue")) { error in
            XCTAssertEqual(SiftError.IncompatibleTypes(message: ""), error as! SiftError)
        }
    }

    func testThrowsErrorIfValueIsNil() {
        XCTAssertThrowsError(try sift.readString(from: data, key: "nullValue")) { error in
            XCTAssertEqual(SiftError.NullValue, error as! SiftError)
        }
    }

    func testValueIsReadSuccessfully() throws {
        let value = try sift.readString(from: data, key: "correctValue")
        XCTAssertEqual("some value", value)
    }

    func testReturnsDefaultValueWhenKeyIsNotFound() {
        let value = sift.readString(from: data, key: "random key", defaultValue: "def val")
        XCTAssertEqual("def val", value)
    }

    func testReturnsDefaultValueWhenValueIsOfWrongType() {
        let value = sift.readString(from: data, key: "wrongValue", defaultValue: "def val")
        XCTAssertEqual("def val", value)
    }

    func testReturnsDefaultValueWhenValueIsNull() {
        let value = sift.readString(from: data, key: "nullValue", defaultValue: "def val")
        XCTAssertEqual("def val", value)
    }

    func testDefaultValueIsIgnoredWhenValueIsReadSuccessfully() {
        let value = sift.readString(from: data, key: "correctValue", defaultValue: "def val")
        XCTAssertEqual("some value", value)
    }

    func testReadValuesFromComplexDictionary() throws {
        let innerDict1: [String: Any?] = ["innerString": "inner1Val",
            "innerDoubleArray": [1.2, 324.23, 434.2323]]
        let dictList: [[String: Any?]] = [["dictList1String": "aMS1"],
            ["dictList2Int": 5],
            ["dictList3Array": ["a", "b", "c"]]]
        let data: [String: Any?] =
            ["null": nil,
                "int": 1,
                "string": "some string",
                "float": 2.1,
                "double": 12.43234324,
                "intArray": [1, 2, 3],
                "stringArray": ["valOne", "valTwo", "valThree"],
                "innerDict": innerDict1,
                "dictList": dictList]

        XCTAssertEqual(nil, sift.readString(from: data, key: "null", defaultValue: nil))
        XCTAssertEqual(1, try sift.readNumber(from: data, key: "int"))
        XCTAssertEqual("some string", try sift.readString(from: data, key: "string"))
        XCTAssertEqual(2.1, try sift.readNumber(from: data, key: "float"))
        XCTAssertEqual(12.43234324, try sift.readNumber(from: data, key: "double"))
        XCTAssertEqual([1, 2, 3], try sift.readNumberList(from: data, key: "intArray"))
        XCTAssertEqual(["valOne", "valTwo", "valThree"], try sift.readStringList(from: data, key: "stringArray"))

        let parsedInnerDict1 = try sift.readDictionary(from: data, key: "innerDict")
        XCTAssertEqual("inner1Val", try sift.readString(from: parsedInnerDict1, key: "innerString"))
        XCTAssertEqual([1.2, 324.23, 434.2323], try sift.readNumberList(from: parsedInnerDict1, key: "innerDoubleArray"))

        let parsedDictList = try sift.readDictionaryList(from: data, key: "dictList")
        XCTAssertEqual("aMS1", try sift.readString(from:parsedDictList[0], key: "dictList1String"))
        XCTAssertEqual(5, try sift.readNumber(from:parsedDictList[1], key: "dictList2Int"))
        XCTAssertEqual(["a", "b", "c"], try sift.readStringList(from:parsedDictList[2], key: "dictList3Array"))
    }
    
}
