//
//  AppBackgroundStyle.swift
//  mkodo
//
//  Created by Shubham Choudhary on 13/08/2024.
//

import SwiftUI

struct AppBackgroundStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        ZStack {
            Color.blue.opacity(0.3)
                .ignoresSafeArea()
            content
        }
    }
}

extension View {
    func appBackgroundStyle() -> some View {
        modifier(AppBackgroundStyle())
    }
}
