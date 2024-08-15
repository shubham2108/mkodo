//
//  NumberView.swift
//  mkodo
//
//  Created by Shubham Choudhary on 12/08/2024.
//

import SwiftUI

struct NumberView: View {
    enum Constants {
        static let strokeWidth: CGFloat = 8
        static let backgroundColor = Color.red
        static let opacity = 0.8
    }
    
    private let number: String
    private let hasBorder: Bool
    
    init(_ number: String, _ hasBorder: Bool) {
        self.number = number
        self.hasBorder = hasBorder
    }
    
    var body: some View {
        Text(number)
            .font(.body.weight(.heavy))
            .foregroundStyle(.white)
            .padding(.all, 8)
            .frame(minWidth: 55)
            .background {
                Circle()
                    .stroke(.white, lineWidth: hasBorder ? Constants.strokeWidth: .zero)
                    .fill(Constants.backgroundColor.opacity(Constants.opacity))
            }
    }
}

#Preview {
    NumberView("12", true)
}
