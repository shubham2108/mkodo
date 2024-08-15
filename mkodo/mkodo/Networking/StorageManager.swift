//
//  StorageManager.swift
//  mkodo
//
//  Created by Shubham Choudhary on 12/08/2024.
//

import Foundation

protocol StorageManaging {
    func loadJson<T: Decodable>(_ file: String) async throws -> T
}

final class StorageManager: StorageManaging {
    private lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    

    func loadJson<T: Decodable>(_ file: String) async throws -> T {
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
}

