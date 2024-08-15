//
//  HomeViewScenarios.swift
//  mkodoUITests
//
//  Created by Shubham Choudhary on 14/08/2024.
//

import XCTest

final class HomeViewScenarios: XCTestCase {
    
    let application = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func testHomeViewContent() throws {
        application.launch()
        
        try HomeScreen()
            .assertStaticScore()
    }

}
