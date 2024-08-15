//
//  DrawDetailView.swift
//  mkodo
//
//  Created by Shubham Choudhary on 12/08/2024.
//

import SwiftUI

struct DrawDetailView: View {
    enum Constants {
        static let viewTitle = "Draw Details"
        static let ticketTitle = "LOTTO"
        static let cornerRadius: CGFloat = 30
        static let columns: [GridItem] = [.init(.adaptive(minimum: 45, maximum: 50), spacing: .zero)]
    }
    
    let viewModel: DrawDetailViewModel
    
    var body: some View {
        VStack {
            detailsCard
            Spacer()
        }
        .appBackgroundStyle()
        .navigationTitle(Constants.viewTitle)
    }
}

private extension DrawDetailView {
    var detailsCard: some View {
        VStack(spacing: 20) {
            Text(Constants.ticketTitle)
                .font(.largeTitle.bold())
            Text(viewModel.draw.date)
                .font(.title2.bold())
            numbersView
            Text(viewModel.draw.topPrize)
                .font(.title.bold())
        }
        .foregroundStyle(.white)
        .padding(.vertical, 20)
        .cardStyle(Constants.cornerRadius)
        .padding(.all, 12)
    }
    
    var numbersView: some View {
        LazyVGrid(columns: Constants.columns, spacing: 16) {
            ForEach(viewModel.draw.numbers, id: \.number) {
                NumberView($0.number, $0.isBonusBall)
            }
        }
    }
}
