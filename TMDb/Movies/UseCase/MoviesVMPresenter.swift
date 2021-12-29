//
//  MoviesVMPresenter.swift
//  TMDb
//
//  Created by Rone Shender Loza Aliaga on 29/12/21.
//

import Foundation
import SwiftUI

final class MoviesVMPresenter: MoviesUseCaseOutput, ObservableObject {
    
    @Published var state: MoviesState
    
    init(state: MoviesState = MoviesState()) {
        self.state = state
    }
    
    func setTopRated(_ results: [MovieResult]) {
        DispatchQueue.main.async {
            self.state = self.state.build(model:
                                            self.state.model.build(
                                                categories:
                                                    self.state.buildCategories(
                                                        data: results,
                                                        id: MovieCategoryType.topRated,
                                                        page: self.state.model.topRatedPage),
                                                topRatedIsLoading: false))
        }
    }
    
    func setPopular(_ results: [MovieResult]) {
        DispatchQueue.main.async {
            self.state = self.state.build(model:
                                            self.state.model.build(
                                                categories:
                                                    self.state.buildCategories(
                                                        data: results,
                                                        id: MovieCategoryType.popular,
                                                        page: self.state.model.popularPage),
                                                popularIsLoading: false))
        }
    }
    
    func setUpcoming(_ results: [MovieResult]) {
        DispatchQueue.main.async {
            self.state = self.state.build(model:
                                            self.state.model.build(
                                                categories: self.state.buildCategories(
                                                    data: results,
                                                    id: MovieCategoryType.upcoming,
                                                    page: self.state.model.upcomingPage),
                                                upcomingIsLoading: false))
        }
    }
    
    func setFilteredMovies(_ results: [MovieResult]) {
        var movies = self.state.model.movies
        if self.state.model.searchPage > 1 {
            movies.append(contentsOf: results)
        } else {
            movies = results
        }
        DispatchQueue.main.async {
            self.state = self.state.build(model: self.state.model.build(movies: movies,
                                                                        searchIsLoading: false))
        }
    }
    
    func setVideoId(_ videoId: String) {
        DispatchQueue.main.async {
            self.state = self.state.build(model: self.state.model.build(videoId: videoId))
        }
    }
    
}
