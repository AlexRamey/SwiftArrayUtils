import XCTest
@testable import ArrayUtils

/// TODO: Write a script that auto-generates XCTestManifests.swift and ../LinuxMain.swift
/// based on the other contents in this directory 
/// (i.e. produce a code generator) (if possible, integrate it into the swift build process)

class RadixSortTests : XCTestCase {

    func testWellFormedInput() {
        let jumbled = [987, 900, 999, 5, 21, 0, 69, 75, 74, 1000]
        let solution = [0, 5, 21, 69, 74, 75, 900, 987, 999, 1000]
        XCTAssertEqual(jumbled.radixSort(), solution, "Incorrect Sort.")
    }

    func testMaxValueZero() {
        let jumbled = [0]
        let solution = [0]
        XCTAssertEqual(jumbled.radixSort(), solution, "Incorrect Sort.")
    }

    func testNegativeNumbers() {
        let jumbled = [-75, -74, -6, -9, 7, 23, 21, 100]
        let solution = [-75, -74, -9, -6, 7, 21, 23, 100]
        XCTAssertEqual(jumbled.radixSort(), solution, "Incorrect Sort.")
    }

    func
    testEmptyInput() {
        let jumbled:[Int] = []
        let solution:[Int] = []
        XCTAssertEqual(jumbled.radixSort(), solution, "Incorrect Sort.")
    }
}
