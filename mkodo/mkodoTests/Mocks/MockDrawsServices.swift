//
//  MockDrawsServices.swift
//  mkodoTests
//
//  Created by Shubham Choudhary on 14/08/2024.
//

@testable import mkodo

final class MockDrawsServices: DrawsProviding {
    var response: DrawsResponse?

    func fetchDraws() async throws -> DrawsResponse {
        guard let response else { throw NetworkError.invalidJSON("Invalid json") }
        
        return response
    }
}
