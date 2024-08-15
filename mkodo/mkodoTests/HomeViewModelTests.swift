//
//  HomeViewModelTests.swift
//  mkodoTests
//
//  Created by Shubham Choudhary on 14/08/2024.
//

import XCTest
@testable import mkodo

final class HomeViewModelTests: XCTestCase {

    private var viewModel: HomeViewModel!
    private var drawsProvider: MockDrawsServices!
    
    private lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    override func setUpWithError() throws {
        try super.setUpWithError()
    
        drawsProvider = MockDrawsServices()
        viewModel = HomeViewModel(drawsServices: drawsProvider)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        drawsProvider = nil
        viewModel = nil
    }
}

// Response data tests
extension HomeViewModelTests {
    
    func testGivenHomeScreen_whenSuccessResponse_thenDrawsHasCorrectData() async {
        drawsProvider.response = mockDraws
        await viewModel.fetchDraws()
        
        XCTAssertEqual(viewModel.draws.count, 4)
    }
    
    func testGivenHomeScreen_whenFailedResponse_thenDrawsIsEmpty() async {
        await viewModel.fetchDraws()
        
        XCTAssertTrue(viewModel.draws.isEmpty)
    }
    
    func testGivenHomeScreen_whenSuccessResponse_thenDrawsSortedInDecendingOrder() async {
        drawsProvider.response = mockDraws
        await viewModel.fetchDraws()
        
        XCTAssertEqual(viewModel.draws[0].date, "May 19, 2023")
        XCTAssertEqual(viewModel.draws[1].date, "May 18, 2023")
        XCTAssertEqual(viewModel.draws[2].date, "May 17, 2023")
        XCTAssertEqual(viewModel.draws[3].date, "May 15, 2023")
    }
}


// isLoading tests
extension HomeViewModelTests {
    
    func testGivenFetchingData_whenSuccessResponse_thenLoadingStatesAreCorrect() throws {
        drawsProvider.response = mockDraws

        let expectation = [true, false]
        let publisher = viewModel.$isLoading.collectNext(2)
        let output = try awaitPublisher(publisher) {
            Task { await viewModel.fetchDraws() }
        }
        
        XCTAssertEqual(expectation, output)
    }
    
    func testGivenFetchingData_whenFailedResponse_thenLoadingStatesAreCorrect() throws {
        drawsProvider.response = nil

        let expectation = [true, false]
        let publisher = viewModel.$isLoading.collectNext(2)
        let output = try awaitPublisher(publisher) {
            Task { await viewModel.fetchDraws() }
        }
        
        XCTAssertEqual(expectation, output)
        
    }
}

// ErrorAlert tests
extension HomeViewModelTests {
    
    func testGivenFetchingData_whenSuccessResponse_thenNoErrorAlert() async {
        drawsProvider.response = mockDraws
        await viewModel.fetchDraws()
        
        XCTAssertFalse(viewModel.showAlert)
        XCTAssertTrue(viewModel.alertMessage.isEmpty)
    }
    
    func testGivenFetchingData_whenFailedResponse_thenShowErrorAlert() async {
        drawsProvider.response = nil
        await viewModel.fetchDraws()
        
        XCTAssertTrue(viewModel.showAlert)
        XCTAssertFalse(viewModel.alertMessage.isEmpty)
    }
}


//MARK: Mock data

private extension HomeViewModelTests {
    
    var mockDraws: DrawsResponse {
        let date = formatter.date(from: "2023-05-15") ?? .now
        let one = Draw(id: "1", drawDate: date)
        let two = Draw(id: "2", drawDate: date + 2*24*60*60)
        let three = Draw(id: "3", drawDate: date + 3*24*60*60)
        let four = Draw(id: "4", drawDate: date + 4*24*60*60)

        return DrawsResponse(draws: [one, two, three, four])
    }
}


