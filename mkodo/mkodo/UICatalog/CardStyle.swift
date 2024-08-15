//
//  CardStyle.swift
//  mkodo
//
//  Created by Shubham Choudhary on 12/08/2024.
//

import SwiftUI

struct CardStyle: ViewModifier {
    enum Constants {
        static let shadow: CGFloat = 10
        static let opacity: CGFloat = 0.6
        static let duration: CGFloat = 3
    }
    
    @State private var animate = false
    let cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        GroupBox {
            content
        }
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .backgroundStyle(
            LinearGradient(
                colors: [
                    .purple.opacity(Constants.opacity),
                    .green.opacity(Constants.opacity),
                    .yellow.opacity(Constants.opacity)
                ],
                startPoint: animate ? .topLeading : .bottomTrailing,
                endPoint: animate ? .bottomTrailing : .topTrailing)
        )
        .shadow(color: .primary.opacity(Constants.opacity), radius: 8, x: Constants.shadow, y: Constants.shadow)
        .onAppear {
            withAnimation(animation) { animate.toggle() }
        }
    }
    
    private var animation: Animation {
        .linear
        .speed(0.1)
        .repeatForever(autoreverses: true)
    }
}

extension View {
    func cardStyle(_ cornerRadius: CGFloat = 16) -> some View {
        modifier(CardStyle(cornerRadius: cornerRadius))
    }
}
