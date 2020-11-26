import XCTest
@testable import Sift

class ReadFromArrayTests: XCTestCase {

    private let sift = Sift.init()

    func testThrowsErrorIfArrayIsNull() {
        XCTAssertThrowsError(try sift.readString(from: nil, atIndex: 0)) { error in
            XCTAssertEqual(error.localizedDescription, "The source array is null")
        }
    }

    func testThrowsErrorIfIndexIsNil() {
        XCTAssertThrowsError(try sift.readString(from: ["hello", "hey", "hi"], atIndex: nil)) { error in
            XCTAssertEqual(error.localizedDescription, "The index is null")
        }
    }

    func testThrowsErrorIfIndexIsOutOfBounds() {
        XCTAssertThrowsError(try sift.readString(from: ["hello", "hey", "hi"], atIndex: 4)) { error in
            XCTAssertEqual(error.localizedDescription, "Index 4 out of bounds")
        }
    }

    func testThrowsErrorIfValueTypeIsWrong() {
        let array = [1, 2, 3]
        XCTAssertThrowsError(try sift.readString(from: [1, 2, 3], atIndex: 1)) { error in
            let value = array[1]
            XCTAssertEqual(error.localizedDescription, "The value type is not the same as the requested one.\nIndex: 1\nRequested Type: String.Type\nFound: \(type(of: value))")
        }
    }

    func testThrowsErrorIfValueIsNil() {
        XCTAssertThrowsError(try sift.readString(from: ["hello", "hey", nil], atIndex: 2)) { error in
            XCTAssertEqual(error.localizedDescription, "The value at index 2 is null")
        }
    }

    func testValueIsReadSuccessfully() throws {
        let value = try sift.readString(from: ["hello", "hey", "hi"], atIndex: 1)
        XCTAssertEqual("hey", value)
    }

    func testReturnsDefaultValueWhenIndexIsOutOfBounds() {
        let value = sift.readString(from: ["hello", "hey"], atIndex: 4, defaultValue: "def val")
        XCTAssertEqual("def val", value)
    }

    func testReturnsDefaultValueWhenValueIsOfWrongType() {
        let value = sift.readString(from: [1, 2, 3], atIndex: 1, defaultValue: "def val")
        XCTAssertEqual("def val", value)
    }

    func testReturnsDefaultValueWhenValueIsNull() {
        let value = sift.readString(from: ["hello", nil, "hey"], atIndex: 1, defaultValue: "def val")
        XCTAssertEqual("def val", value)
    }

    func testDefaultValueIsIgnoredWhenValueIsReadSuccessfully() {
        let value = sift.readString(from: ["hello", "hey", "hi"], atIndex: 2, defaultValue: "def val")
        XCTAssertEqual("hi", value)
    }

}
