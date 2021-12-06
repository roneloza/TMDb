//
//  MoviesState.swift
//  TMDb
//
//  Created by Rone Shender on 24/11/21.
//

import ReduxCore
import Foundation

struct MoviesState: ReduxState {
    
    var model: MoviesStateData
    
    init(model: MoviesStateData) {
        self.model = model
    }
    
    func build(model: MoviesStateData? = nil) -> MoviesState {
        .init(model: model ?? self.model)
    }
    
}
