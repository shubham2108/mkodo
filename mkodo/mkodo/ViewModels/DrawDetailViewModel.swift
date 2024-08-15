//
//  DrawDetailViewModel.swift
//  mkodo
//
//  Created by Shubham Choudhary on 12/08/2024.
//

import Observation

@Observable final class DrawDetailViewModel: Identifiable {
    let draw: Draw
    
    init(draw: Draw) {
        self.draw = draw
    }
}
