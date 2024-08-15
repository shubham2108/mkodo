//
//  DrawsServices.swift
//  mkodo
//
//  Created by Shubham Choudhary on 12/08/2024.
//

import Foundation

enum NetworkError: Error {
    case invalidJSON(_ error: String)
    case badURL
    case invalidRequest
}

protocol DrawsProviding {
    func fetchDraws() async throws -> DrawsResponse
}

final class DrawsServices: DrawsProviding {
    enum RequestType {
        case local
        case remote
    }
    
    private let requestType: RequestType
    private let storageManager: StorageManaging
    
    init(
        _ requestType: RequestType = .local,
        storageManager: StorageManaging = StorageManager())
    {
        self.requestType = requestType
        self.storageManager = storageManager
    }
    
    func fetchDraws() async throws -> DrawsResponse {
        if requestType == .local {
            return try await storageManager.loadJson("draws")
        }

        throw NetworkError.invalidRequest
    }
}



