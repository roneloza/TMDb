//
//  MoviesVMUseCase.swift
//  TMDb
//
//  Created by Rone Shender Loza Aliaga on 29/12/21.
//

import Foundation

final class MoviesVMUseCase: MoviesUseCaseInput {
    
    let presenter: MoviesUseCaseOutput?
    private let middleware: MoviesMiddlewareDatasource
    
    init(presenter: MoviesUseCaseOutput? = nil,
         middleware: MoviesMiddlewareDatasource) {
        self.presenter = presenter
        self.middleware = middleware
    }
    
    func getTopRated(page: Int = 1) {
        guard let presenter = self.presenter else {
            return
        }
        if !presenter.state.model.topRatedIsLoading {
            presenter.state.model.topRatedIsLoading = true
            presenter.state.model.topRatedPage = page
            self.middleware.getTopRated(page: presenter.state.model.topRatedPage)
        }
    }
    
    func getTopRatedPagination(item: MovieResult) {
        guard let presenter = self.presenter else {
            return
        }
        if let last = presenter.state.model.categories.filter({ $0.id == MovieCategoryType.topRated }).last?.movies.last,
           last.id == item.id,
           !presenter.state.model.topRatedIsLoading {
            self.getTopRated(page: presenter.state.model.topRatedPage + 1)
        }
    }
    
    func getPopular(page: Int = 1) {
        guard let presenter = self.presenter else {
            return
        }
        if !presenter.state.model.popularIsLoading {
            presenter.state.model.popularIsLoading = true
            presenter.state.model.popularPage = page
            self.middleware.getPopular(page: presenter.state.model.popularPage)
        }
    }
    
    func getPopularPagination(item: MovieResult) {
        guard let presenter = self.presenter else {
            return
        }
        if let last = presenter.state.model.categories.filter({ $0.id == MovieCategoryType.popular }).last?.movies.last,
           last.id == item.id,
           !presenter.state.model.popularIsLoading {
            self.getPopular(page: presenter.state.model.popularPage + 1)
        }
    }
    
    func getUpcoming(page: Int = 1) {
        guard let presenter = self.presenter else {
            return
        }
        if !presenter.state.model.upcomingIsLoading {
            presenter.state.model.upcomingIsLoading = true
            presenter.state.model.upcomingPage = page
            self.middleware.getUpcoming(page: presenter.state.model.upcomingPage)
        }
    }
    
    func getUpcomingPagination(item: MovieResult) {
        guard let presenter = self.presenter else {
            return
        }
        if let last = presenter.state.model.categories.filter({ $0.id == MovieCategoryType.upcoming }).last?.movies.last,
           last.id == item.id,
           !presenter.state.model.upcomingIsLoading {
            self.getUpcoming(page: presenter.state.model.upcomingPage + 1)
        }
    }
    
    func getFilteredMovies(text: String, page: Int) {
        guard let presenter = self.presenter else {
            return
        }
        if !presenter.state.model.searchIsLoading {
            presenter.state.model.searchIsLoading = true
            presenter.state.model.searchPage = page
            self.middleware.getFilteredMovies(text: text,
                                              page: presenter.state.model.searchPage)
        }
    }
    
    func getFilteredMoviesPagination(item: MovieResult) {
        guard let presenter = self.presenter else {
            return
        }
        if let last = presenter.state.model.movies.last,
           last.id == item.id,
           !presenter.state.model.searchIsLoading {
            self.getFilteredMovies(text: presenter.state.model.searchText,
                                   page: presenter.state.model.searchPage + 1)
        }
    }
    
    func getImageData(movie: MovieResult, completion: ((Data) -> Void)? = nil) {
        self.middleware.getImageData(movie: movie,
                                     completion: completion)
    }
    
    func getVideo(movieId: Int64, completion: ((_ videoId: String) -> Void)?) {
        self.middleware.getVideo(movieId: movieId,
                                 completion: completion)
    }
    
    func setImageData(movie: MovieResult) {
        self.middleware.setImageData(movie: movie)
    }
}
