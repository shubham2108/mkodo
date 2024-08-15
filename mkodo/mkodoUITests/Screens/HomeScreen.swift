//
//  HomeScreen.swift
//  mkodoUITests
//
//  Created by Shubham Choudhary on 14/08/2024.
//

import XCTest

final class HomeScreen {
    
    private let identifier = "home_screen"
    
    private var cells = [XCUIElement]()
    
    init(application: XCUIApplication = .init()) {
        let screen = application.otherElements[identifier]
        
        for i in 1...3 {
            let card = screen.otherElements["draw-" + "\(i)"]
            cells.append(card.staticTexts["draw_date"])
        }
    }
    
    @discardableResult
    func assertStaticScore() throws -> Self {
        let expectedDates = ["May 15, 2023", "May 22, 2023", "May 29, 2023"]
        for i in 0...2 {
            try XCTUnwrap(cells[i]).waitForText(expectedDates[i])
        }
        return self
    }
}

