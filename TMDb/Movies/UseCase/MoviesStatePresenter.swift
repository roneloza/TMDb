//
//  MoviesStatePresenter.swift
//  TMDb
//
//  Created by Rone Shender Loza Aliaga on 29/12/21.
//

import Foundation
import ReduxCore

final class MoviesStatePresenter: MoviesUseCaseOutput {
    
    weak var store: ReduxStore<MoviesState>? = nil
    
    init(store: ReduxStore<MoviesState>? = nil) {
        self.store = store
    }
    
    func setTopRated(_ results: [MovieResult]) {
        self.store?.dispatch(MoviesAction.setTopRated(results))
    }
    
    func setPopular(_ results: [MovieResult]) {
        self.store?.dispatch(MoviesAction.setPopular(results))
    }
    
    func setUpcoming(_ results: [MovieResult]) {
        self.store?.dispatch(MoviesAction.setUpcoming(results))
    }
    
    func setFilteredMovies(_ results: [MovieResult]) {
        self.store?.dispatch(MoviesAction.setFilteredMovies(results))
    }
    
    func setVideoId(_ videoId: String) {
        self.store?.dispatch(MoviesAction.setVideoId(videoId))
    }
    
}
