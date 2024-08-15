//
//  MockStorageManager.swift
//  mkodoTests
//
//  Created by Shubham Choudhary on 14/08/2024.
//

@testable import mkodo

import Foundation

final class MockStorageManager: StorageManaging {
    
    private(set) var isLocal = false
    
    private lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    
    func loadJson<T: Decodable>(_ file: String) async throws -> T {
        isLocal = true

        if let url = Bundle.main.url(forResource: file, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(formatter)
                return try decoder.decode(T.self, from: data)
            } catch {
                throw NetworkError.invalidJSON(error.localizedDescription)
            }
        }
        
        throw NetworkError.badURL
    }
    
    func reset() {
        isLocal = false
    }
}
