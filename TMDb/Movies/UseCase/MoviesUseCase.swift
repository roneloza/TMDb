//
//  MoviesUseCase.swift
//  TMDb
//
//  Created by Rone Shender on 6/12/21.
//

import Foundation
import ReduxCore

protocol MoviesUseCases: class {
    
    func getTopRated(page: Int)
    func getTopRatedPagination(item: MovieResult)
    func getPopular(page: Int)
    func getPopularPagination(item: MovieResult)
    func getUpcoming(page: Int)
    func getUpcomingPagination(item: MovieResult)
    func getFilteredMovies(text: String, page: Int)
    func getFilteredMoviesPagination(item: MovieResult)
    func setImageData(movie: MovieResult)
    func getImageData(movie: MovieResult, completion: ((Data) -> Void)?)
    func getVideo(movieId: Int64, completion: ((_ videoId: String) -> Void)?)
    
}

final class MoviesStateUseCase: MoviesUseCases {
    
    weak var store: ReduxStore<MoviesState>? = nil
    
    init(store: ReduxStore<MoviesState>? = nil) {
        self.store = store ?? self.store
    }
    
    func getTopRated(page: Int = 1) {
        guard let store = self.store else {
            return
        }
        if !store.state.model.topRatedIsLoading {
            store.state.model.topRatedIsLoading = true
            store.state.model.topRatedPage = page
            store.dispatch(MoviesAction.getTopRated(page: store.state.model.topRatedPage))
        }
    }
    
    func getTopRatedPagination(item: MovieResult) {
        guard let store = self.store else {
            return
        }
        if let last = store.state.model.categories.filter({ $0.id == MovieCategoryType.topRated }).last?.movies.last,
           last.id == item.id,
           !store.state.model.topRatedIsLoading {
            self.getTopRated(page: store.state.model.topRatedPage + 1)
        }
    }
    
    func getPopular(page: Int = 1) {
        guard let store = self.store else {
            return
        }
        if !store.state.model.popularIsLoading {
            store.state.model.popularIsLoading = true
            store.state.model.popularPage = page
            store.dispatch(MoviesAction.getPopular(page: store.state.model.popularPage))
        }
    }
    
    func getPopularPagination(item: MovieResult) {
        guard let store = self.store else {
            return
        }
        if let last = store.state.model.categories.filter({ $0.id == MovieCategoryType.popular }).last?.movies.last,
           last.id == item.id,
           !store.state.model.popularIsLoading {
            self.getPopular(page: store.state.model.popularPage + 1)
        }
    }
    
    func getUpcoming(page: Int = 1) {
        guard let store = self.store else {
            return
        }
        if !store.state.model.upcomingIsLoading {
            store.state.model.upcomingIsLoading = true
            store.state.model.upcomingPage = page
            store.dispatch(MoviesAction.getUpcoming(page: store.state.model.upcomingPage))
        }
    }
    
    func getUpcomingPagination(item: MovieResult) {
        guard let store = self.store else {
            return
        }
        if let last = store.state.model.categories.filter({ $0.id == MovieCategoryType.upcoming }).last?.movies.last,
           last.id == item.id,
           !store.state.model.upcomingIsLoading {
            self.getUpcoming(page: store.state.model.upcomingPage + 1)
        }
    }
    
    func getFilteredMovies(text: String, page: Int) {
        guard let store = self.store else {
            return
        }
        if !store.state.model.searchIsLoading {
            store.state.model.searchIsLoading = true
            store.state.model.searchPage = page
            store.dispatch(MoviesAction.getFilteredMovies(text: text,
                                                          page: store.state.model.searchPage))
        }
    }
    
    func getFilteredMoviesPagination(item: MovieResult) {
        guard let store = self.store else {
            return
        }
        if let last = store.state.model.movies.last,
           last.id == item.id,
           !store.state.model.searchIsLoading {
            self.getFilteredMovies(text: store.state.model.searchText,
                                   page: store.state.model.searchPage + 1)
        }
    }
    
    func setImageData(movie: MovieResult) {
        self.store?.dispatch(MoviesAction.setImageData(movie: movie))
    }
    
    func getImageData(movie: MovieResult, completion: ((Data) -> Void)? = nil) {
        self.store?.dispatch(MoviesAction.getImageData(movie: movie,
                                                       completion: completion))
    }
    
    func getVideo(movieId: Int64, completion: ((_ videoId: String) -> Void)?) {
        self.store?.dispatch(MoviesAction.getVideo(movieId: movieId,
                                                   completion: completion))
    }
    
}