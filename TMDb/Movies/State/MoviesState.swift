//
//  MoviesState.swift
//  TMDb
//
//  Created by Rone Shender on 24/11/21.
//

import ReduxCore
import Foundation

protocol MoviesStateModel {
    
    var categories: [MovieCategory] { get }
    var topRatedPage: Int { set get }
    var topRatedIsLoading: Bool { set get }
    var popularPage: Int { set get }
    var popularIsLoading: Bool { set get }
    var upcomingPage: Int { set get }
    var upcomingIsLoading: Bool { set get }
    var searchText: String { set get }
    var movies: [MovieResult] { get }
    var searchPage: Int { set get }
    var searchIsLoading: Bool { set get }
    
}

protocol MoviesStateUseCases {
    
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

struct MoviesState: ReduxState, MoviesStateModel {
    
    let categories: [MovieCategory]
    var topRatedPage: Int = 1
    var topRatedIsLoading: Bool = false
    var popularPage: Int = 1
    var popularIsLoading: Bool = false
    var upcomingPage: Int = 1
    var upcomingIsLoading: Bool = false
    var searchText: String
    let movies: [MovieResult]
    var searchPage: Int = 1
    var searchIsLoading: Bool = false
    let videoId: String
    weak var store: ReduxStore<MoviesState>? = nil
    
    
    init(categories: [MovieCategory] = [],
         topRatedPage: Int = 1,
         topRatedIsLoading: Bool = false,
         popularPage: Int = 1,
         popularIsLoading: Bool = false,
         upcomingPage: Int = 1,
         upcomingIsLoading: Bool = false,
         searchText: String = "",
         movies: [MovieResult] = [],
         searchPage: Int = 1,
         searchIsLoading: Bool = false,
         videoId: String = "",
         store: ReduxStore<MoviesState>? = nil) {
        self.categories = categories
        self.topRatedPage = topRatedPage
        self.topRatedIsLoading = topRatedIsLoading
        self.popularPage = popularPage
        self.popularIsLoading = popularIsLoading
        self.upcomingPage = upcomingPage
        self.upcomingIsLoading = upcomingIsLoading
        self.searchText = searchText
        self.movies = movies
        self.searchPage = searchPage
        self.searchIsLoading = searchIsLoading
        self.videoId = videoId
        self.store = store ?? self.store
    }
    
    func build(categories: [MovieCategory]? = nil,
               topRatedPage: Int? = nil,
               topRatedIsLoading: Bool? = nil,
               popularPage: Int? = nil,
               popularIsLoading: Bool? = nil,
               upcomingPage: Int? = nil,
               upcomingIsLoading: Bool? = nil,
               searchText: String? = nil,
               movies: [MovieResult]? = nil,
               searchPage: Int? = nil,
               searchIsLoading: Bool? = nil,
               videoId: String? = nil,
               store: ReduxStore<MoviesState>? = nil) -> MoviesState {
        .init(categories: categories ?? self.categories,
              topRatedPage: topRatedPage ?? self.topRatedPage,
              topRatedIsLoading: topRatedIsLoading ?? self.topRatedIsLoading,
              popularPage: popularPage ?? self.popularPage,
              popularIsLoading: popularIsLoading ?? self.popularIsLoading,
              upcomingPage: upcomingPage ?? self.upcomingPage,
              upcomingIsLoading: upcomingIsLoading ?? self.upcomingIsLoading,
              searchText: searchText ?? self.searchText,
              movies: movies ?? self.movies,
              searchPage: searchPage ?? self.searchPage,
              searchIsLoading: searchIsLoading ?? self.searchIsLoading,
              videoId: videoId ?? self.videoId,
              store: store ?? self.store)
    }
    
}

extension MoviesState: MoviesStateUseCases {
    
    func getTopRated(page: Int = 1) {
        guard let store = self.store else {
            return
        }
        if !store.state.topRatedIsLoading {
            store.state.topRatedIsLoading = true
            store.state.topRatedPage = page
            store.dispatch(MoviesAction.getTopRated(page: store.state.topRatedPage))
        }
    }
    
    func getTopRatedPagination(item: MovieResult) {
        guard let store = self.store else {
            return
        }
        if let last = store.state.categories.filter({ $0.id == MovieCategoryType.topRated }).last?.movies.last,
           last.id == item.id,
           !store.state.topRatedIsLoading {
            self.getTopRated(page: store.state.topRatedPage + 1)
        }
    }
    
    func getPopular(page: Int = 1) {
        guard let store = self.store else {
            return
        }
        if !store.state.popularIsLoading {
            store.state.popularIsLoading = true
            store.state.popularPage = page
            store.dispatch(MoviesAction.getPopular(page: store.state.popularPage))
        }
    }
    
    func getPopularPagination(item: MovieResult) {
        guard let store = self.store else {
            return
        }
        if let last = store.state.categories.filter({ $0.id == MovieCategoryType.popular }).last?.movies.last,
           last.id == item.id,
           !store.state.popularIsLoading {
            self.getPopular(page: store.state.popularPage + 1)
        }
    }
    
    func getUpcoming(page: Int = 1) {
        guard let store = self.store else {
            return
        }
        if !store.state.upcomingIsLoading {
            store.state.upcomingIsLoading = true
            store.state.upcomingPage = page
            store.dispatch(MoviesAction.getUpcoming(page: store.state.upcomingPage))
        }
    }
    
    func getUpcomingPagination(item: MovieResult) {
        guard let store = self.store else {
            return
        }
        if let last = store.state.categories.filter({ $0.id == MovieCategoryType.upcoming }).last?.movies.last,
           last.id == item.id,
           !store.state.upcomingIsLoading {
            self.getUpcoming(page: store.state.upcomingPage + 1)
        }
    }
    
    func getFilteredMovies(text: String, page: Int) {
        guard let store = self.store else {
            return
        }
        if !store.state.searchIsLoading {
            store.state.searchIsLoading = true
            store.state.searchPage = page
            store.dispatch(MoviesAction.getFilteredMovies(text: text,
                                                          page: store.state.searchPage))
        }
    }
    
    func getFilteredMoviesPagination(item: MovieResult) {
        guard let store = self.store else {
            return
        }
        if let last = store.state.movies.last,
           last.id == item.id,
           !store.state.searchIsLoading {
            self.getFilteredMovies(text: store.state.searchText,
                                   page: store.state.searchPage + 1)
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
