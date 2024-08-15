//
//  HomeViewModel.swift
//  mkodo
//
//  Created by Shubham Choudhary on 12/08/2024.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
    @Published var draws: [Draw] = []
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var navigationHandler: NavigationHandler = .init()
    @Published private(set) var alertMessage: String = ""
    
    private let services: DrawsProviding
    
    init(drawsServices: DrawsProviding = DrawsServices()) {
        services = drawsServices
    }
    
    @MainActor
    func fetchDraws() async {
        do {
            isLoading = true
            let response = try await services.fetchDraws()
            draws = response.draws.sorted { $0.drawDate > $1.drawDate }
            isLoading = false
        } catch {
            alertMessage = error.localizedDescription
            isLoading = false
            showAlert = true
        }
    }
    
    func showDetails( for draw: Draw) {
        navigationHandler.append(Route.drawDetails(.init(draw: draw)))
    }
}
