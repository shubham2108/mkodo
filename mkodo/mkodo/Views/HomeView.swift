//
//  ContentView.swift
//  mkodo
//
//  Created by Shubham Choudhary on 12/08/2024.
//

import SwiftUI

struct HomeView: View {
    enum Constants {
        static let viewTitle = "Your Draws"
        static let drawData = "Draw date"
        static let alertTitle = "Alert"
        static let okButton = "Ok"
        static let shadow: CGFloat = 10
    }
    
    enum AccessibilityId {
        static let home = "home_screen"
        static let date = "draw_date"
        static let dateTitle = "draw_title"
    }

    @StateObject var viewModel = HomeViewModel()

    var body: some View {
        NavigationStack(path: $viewModel.navigationHandler.paths) {
            listView
                .appBackgroundStyle()
                .navigationTitle(Constants.viewTitle)
                .navigationDestination(for: Route.self) { $0 }
                .alert(Constants.alertTitle, isPresented: $viewModel.showAlert) {
                    Button(Constants.okButton, role: .cancel) { }
                } message: {
                    Text(viewModel.alertMessage)
                }
                .task { await viewModel.fetchDraws() }
        }
        .accessibilityIdentifier(AccessibilityId.home)
    }
}

private extension HomeView {
    var listView: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.draws, id: \.id) { draw in
                    drawView(date: draw.date)
                        .accessibilityIdentifier(draw.id)
                        .transition(.move(edge: .bottom))
                        .onTapGesture { viewModel.showDetails(for: draw) }
                }
            }
            .animation(.easeIn(duration: 0.5), value: viewModel.draws)
        }
        .redacted(reason: viewModel.isLoading ? .placeholder : .invalidated)
    }
}

private extension HomeView {
    func drawView(date: String) -> some View {
        HStack(spacing: 20) {
            iconView
            Divider()
                .frame(width: 1)
                .background(.white)
            VStack(alignment: .leading, spacing: 12) {
                Text(Constants.drawData)
                    .font(.title3.bold())
                    .accessibilityIdentifier(AccessibilityId.dateTitle)
                Text(date)
                    .font(.title2.bold())
                    .accessibilityIdentifier(AccessibilityId.date)
            }
            
            Spacer()
        }
        .foregroundStyle(.white)
        .cardStyle()
        .padding()
    }
    
    var iconView: some View {
        Image(systemName: "ticket")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 60)
            .padding()
    }
}

#Preview {
    HomeView()
}
