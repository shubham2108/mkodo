//
//  NavigationHandler.swift
//  mkodo
//
//  Created by Shubham Choudhary on 12/08/2024.
//

import SwiftUI

@Observable final class NavigationHandler {
    
    var paths = NavigationPath()
    
    func append<T: Hashable>(_ item: T) {
        paths.append(item)
    }
    
    func pop() {
        paths.removeLast()
    }
    
    func popToRoot() {
        paths.removeLast(paths.count)
    }
}
