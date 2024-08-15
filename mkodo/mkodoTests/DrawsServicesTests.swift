//
//  DrawsServicesTests.swift
//  mkodoTests
//
//  Created by Shubham Choudhary on 14/08/2024.
//

import XCTest
@testable import mkodo

final class DrawsServicesTests: XCTestCase {
    private var storageManager: MockStorageManager!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        storageManager = MockStorageManager()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        storageManager.reset()
    }
    
    func testWhenRequestTypeLocal_thenDataFetchedFromLocal() async throws {
        XCTAssertFalse(storageManager.isLocal)
        
        let service = DrawsServices(.local, storageManager: storageManager)
        _ = try await service.fetchDraws()
        
        XCTAssertTrue(storageManager.isLocal)
    }
    
    func testWhenRequestTypeRemote_thenDataNotFetchedFromLocal() async throws {
        let expectation = expectation(description: #function)
        
        XCTAssertFalse(storageManager.isLocal)
        let service = DrawsServices(.remote, storageManager: storageManager)
        
        do {
            _ = try await service.fetchDraws()
            XCTFail("Failure expected")
        } catch {
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 1)
    }
}
