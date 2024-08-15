//
//  XCUIElement+Ext.swift
//  mkodoUITests
//
//  Created by Shubham Choudhary on 14/08/2024.
//

import XCTest

extension XCUIElement {
    
    func waitForText(_ text: String, timeout: TimeInterval = 10, file: StaticString = #file, line: UInt = #line) {
        let predicateEvaluation = NSPredicate(format: "label CONTAINS[c] %@", text)
        let expectaion = XCTNSPredicateExpectation(predicate: predicateEvaluation, object: self)
        let result = XCTWaiter.wait(for: [expectaion], timeout: timeout)
        
        XCTAssertEqual(result, .completed, "\(text) did not appear", file: file, line: line)
    }
}
