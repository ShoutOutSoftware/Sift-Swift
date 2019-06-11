//
//  ReadDictionaryTests.swift
//  SiftTests
//
//  Created by Obaid Ahmed Mohammed on 14/11/17.
//  Copyright © 2017 Shoutout Software. All rights reserved.
//

import XCTest
@testable import Sift

class ReadDictionaryTests: XCTestCase {

    private let sift = Sift.init()
    private let data: [String: Any?] = ["wrongValue": 2, "nullValue": nil, "correctValue": "some value"]

    func testThrowsErrorIfMapIsNull() {
        XCTAssertThrowsError(try sift.readString(from: nil, key: "randomKey")) { error in
            XCTAssertEqual(error.localizedDescription, "the map is null")
        }
    }

    func testThrowsErrorIfKeyIsNotFound() {
        XCTAssertThrowsError(try sift.readString(from: data, key: "randomKey")) { error in
            XCTAssertEqual(error.localizedDescription, "key not found")
        }
    }

    func testThrowsErrorIfValueTypeIsWrong() {
        XCTAssertThrowsError(try sift.readString(from: data, key: "wrongValue")) { error in
            let value = data["wrongValue"]!
            XCTAssertEqual(error.localizedDescription, "the value type is not the same as the requested one.\nRequested Type: String.Type\nFound: \(type(of: value!))")
        }
    }

    func testThrowsErrorIfValueIsNil() {
        XCTAssertThrowsError(try sift.readString(from: data, key: "nullValue")) { error in
            XCTAssertEqual(error.localizedDescription, "the value is null")
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
        let data: [String: Any?] =
            ["null": nil,
                "int": 1,
                "string": "some string",
                "float": 2.1,
                "double": 12.43234324,
                "bool": true,
                "intArray": [1, 2, 3],
                "stringArray": ["valOne", "valTwo", "valThree"],
                "innerDict": ["innerString": "inner1Val",
                    "innerDoubleArray": [1.2, 324.23, 434.2323]],
                "dictArray": [["dictArray1String": "aMS1"],
                    ["dictArray2Int": 5],
                    ["dictArray3Array": ["a", "b", "c"]]]]

        XCTAssertEqual(nil, sift.readString(from: data, key: "null", defaultValue: nil))
        XCTAssertEqual(1, try sift.readNumber(from: data, key: "int"))
        XCTAssertEqual("some string", try sift.readString(from: data, key: "string"))
        XCTAssertEqual(2.1, try sift.readNumber(from: data, key: "float"))
        XCTAssertEqual(12.43234324, try sift.readNumber(from: data, key: "double"))
        XCTAssertEqual(true, try sift.readBool(from: data, key: "bool"))
        XCTAssertEqual([1, 2, 3], try sift.readNumberArray(from: data, key: "intArray"))
        XCTAssertEqual(["valOne", "valTwo", "valThree"], try sift.readStringArray(from: data, key: "stringArray"))

        let parsedInnerDict1 = try sift.readDictionary(from: data, key: "innerDict")
        XCTAssertEqual("inner1Val", try sift.readString(from: parsedInnerDict1, key: "innerString"))
        XCTAssertEqual([1.2, 324.23, 434.2323], try sift.readNumberArray(from: parsedInnerDict1, key: "innerDoubleArray"))

        let parsedDictArray = try sift.readDictionaryArray(from: data, key: "dictArray")
        XCTAssertEqual("aMS1", try sift.readString(from: parsedDictArray[0], key: "dictArray1String"))
        XCTAssertEqual(5, try sift.readNumber(from: parsedDictArray[1], key: "dictArray2Int"))
        XCTAssertEqual(["a", "b", "c"], try sift.readStringArray(from: parsedDictArray[2], key: "dictArray3Array"))
    }

}
