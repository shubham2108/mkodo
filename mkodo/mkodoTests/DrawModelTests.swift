//
//  DrawModelTests.swift
//  mkodoTests
//
//  Created by Shubham Choudhary on 14/08/2024.
//

import XCTest
@testable import mkodo

final class DrawModelTests: XCTestCase {

    func testGivenJsonFile_whenDataFetched_thenDataParsedCorrectly() async throws {
        let storageManager = MockStorageManager()
        
        let response: DrawsResponse = try await storageManager.loadJson("draws")
        
        XCTAssertEqual(response.draws.count, 3)
        XCTAssertEqual(response.draws[1].id, "draw-2")
        XCTAssertEqual(response.draws[1].date, "May 22, 2023")
        XCTAssertEqual(response.draws[1].numbers, [
            .init("5"),
            .init("45"),
            .init("51"),
            .init("32"),
            .init("24"),
            .init("18"),
            .init("28", true)
        ])
        XCTAssertEqual(response.draws[1].topPrize, "£6,000,000,000")
    }
}
