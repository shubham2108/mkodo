//
//  Route.swift
//  mkodo
//
//  Created by Shubham Choudhary on 12/08/2024.
//

import SwiftUI

enum Route {
    case drawDetails(DrawDetailViewModel)
}

extension Route: View {
    var body: some View {
        view
    }
    
    @ViewBuilder
    private var view: some View {
        switch self {
        case let .drawDetails(viewModel):
            DrawDetailView(viewModel: viewModel)
        }
    }
}

extension Route: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(hashValue)
    }
    
    static func == (lhs: Route, rhs: Route) -> Bool {
        switch (lhs, rhs) {
        case let (.drawDetails(lhsModel), .drawDetails(rhsModel)):
            return lhsModel.id == rhsModel.id
        }
    }
}

