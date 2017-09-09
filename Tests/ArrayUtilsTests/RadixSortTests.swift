import XCTest
@testable import ArrayUtils

/// Note: Run ../build.pl to auto-generate XCTestManifests.swift and ../LinuxMain.swift
/// based on the contents of this directory

class RadixSortTests : XCTestCase {

    func testWellFormedInput() {
        let jumbled = [987, 900, 999, 5, 21, 0, 69, 75, 74, 1000]
        let solution = [0, 5, 21, 69, 74, 75, 900, 987, 999, 1000]
        XCTAssertEqual(jumbled.radixSorted(), solution, "Incorrect Sort.")
    }

    func testMaxValueZero() {
        let jumbled = [0]
        let solution = [0]
        XCTAssertEqual(jumbled.radixSorted(), solution, "Incorrect Sort.")
    }

    func testNegativeNumbers() {
        let jumbled = [-75, -74, -6, -9, 7, 23, 21, 100]
        let solution = [-75, -74, -9, -6, 7, 21, 23, 100]
        XCTAssertEqual(jumbled.radixSorted(), solution, "Incorrect Sort.")
    }

    func testEmptyInput() {
        let jumbled:[Int] = []
        let solution:[Int] = []
        XCTAssertEqual(jumbled.radixSorted(), solution, "Incorrect Sort.")
    }

    func testWellFormedInput2() {
        let jumbled = [6, 2, 4, 10, -1]
        let solution = [-1, 2, 4, 6, 10]
        XCTAssertEqual(jumbled.radixSorted(), solution, "Incorrect Sort.")
    }
}
