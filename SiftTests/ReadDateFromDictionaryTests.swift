//
//  ReadDateFromDictionaryTests.swift
//  SiftTests
//
//  Created by Mohammed Obaid Ahmed on 29/08/20.
//  Copyright © 2020 Shoutout Software. All rights reserved.
//

import XCTest
@testable import Sift

class ReadDateFromDictionaryTests: XCTestCase {

    private let sift = Sift.init()

    func testThrowsError_IfDateStringIsNotCorrect() {
        XCTAssertThrowsError(try sift.readDate(from: ["date": "wrong date string"], key: "date", dateFormat: "yyyy MM dd")) { error in
            XCTAssertEqual(error.localizedDescription, "Failed to parse date for Key: date, Date: wrong date string, Format: yyyy MM dd")
        }
    }

    func testThrowsError_IfDateFormatStringIsNotCorrect() {
        XCTAssertThrowsError(try sift.readDate(from: ["date": "1990 03 25"], key: "date", dateFormat: "dd xyz")) { error in
            XCTAssertEqual(error.localizedDescription, "Failed to parse date for Key: date, Date: 1990 03 25, Format: dd xyz")
        }
    }

    func testSuccessfullyReadingDates() {
        var _ = try! sift.readDate(from: ["date": "1990 03 25"], key: "date", dateFormat: "yyyy MM dd")
        var _ = try! sift.readDate(from: ["date": "25/03/1990"], key: "date", dateFormat: "dd/MM/yyyy")
        var _ = try! sift.readDate(from: ["date": "25 03 90 12:35"], key: "date", dateFormat: "dd MM yy hh:mm")
    }

}
