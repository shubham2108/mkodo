//
//  DrawDetailViewModelTests.swift
//  mkodoTests
//
//  Created by Shubham Choudhary on 14/08/2024.
//

import XCTest
@testable import mkodo

final class DrawDetailViewModelTests: XCTestCase {
    
    private lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    func testWhenViewModelInitialized_thenDrawDataIsCorrect() async throws {
        let date = formatter.date(from: "2023-05-15") ?? .now
        let draw = Draw(id: "1", drawDate: date, topPrize: "£1234")
        let viewModel = DrawDetailViewModel(draw: draw)
        
        XCTAssertEqual(viewModel.draw.id, "1")
        XCTAssertEqual(viewModel.draw.date, "May 15, 2023")
        XCTAssertEqual(viewModel.draw.topPrize, "£1234")
        XCTAssertEqual(viewModel.draw.numbers, [])
    }
}
