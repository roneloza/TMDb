//
//  MoviesMiddleware.swift
//  TMDb
//
//  Created by Rone Shender on 24/11/21.
//

import ReduxCore
import Foundation
import Combine

protocol MoviesMiddlewareDatasource: AnyObject {
    
    func getTopRated(page: Int)
    func getPopular(page: Int)
    func getUpcoming(page: Int)
    func setImageData(movie: MovieResult)
    func getImageData(movie: MovieResult, completion: ((Data) -> Void)?)
    func getFilteredMovies(text: String, page: Int)
    func getVideo(movieId: Int64, completion: ((_ videoId: String) -> Void)?)
}

final class MoviesMiddleware: ReduxMiddleware<MoviesState>, MoviesMiddlewareDatasource {
    
    private lazy var storeManager: StoreManagerMovie = {
        SQLiteStoreManagerMovie()
    }()
    private lazy var networkManager: NetworkManager = {
        URLSessionNetworkManager()
    }()
    private weak var datasource: MoviesMiddlewareDatasource? {
        self
    }
    
    override func handleDispatch(action: ReduxAction, store: DispatcherObject, parent: DispatcherObject?) {
        switch action {
        case let MoviesAction.getTopRated(page):
            self.datasource?.getTopRated(page: page)
        case let MoviesAction.getPopular(page):
            self.datasource?.getPopular(page: page)
        case let MoviesAction.getUpcoming(page):
            self.datasource?.getUpcoming(page: page)
        case let MoviesAction.setImageData(movie):
            self.datasource?.setImageData(movie: movie)
        case let MoviesAction.getImageData(movie, completion):
            self.datasource?.getImageData(movie: movie, completion: completion)
        case let MoviesAction.getFilteredMovies(text, page):
            self.datasource?.getFilteredMovies(text: text, page: page)
        case let MoviesAction.getVideo(movieId, completion):
            self.datasource?.getVideo(movieId: movieId, completion: completion)
        default:
            break
        }
    }
    
    // MARK: MoviesMiddlewareDatasource
    
    func getTopRated(page: Int = 1) {
        if let url = URLBuilder.getTopRatedMoviesURL(page: page) {
            self.networkManager.dataTask(url: url, type: MovieResponse.self)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure:
                        if let results = self.storeManager.selectMovies(by: .topRated,
                                                                        page: page) {
                            self.store?.dispatch(MoviesAction.setTopRated(results))
                        }
                    case .finished:
                        break
                    }
                }, receiveValue: { response in
                    let results = response.results.map { $0.build(categoryType: .topRated) }
                    self.storeManager.insertMovies(movies: results)
                    self.store?.dispatch(MoviesAction.setTopRated(results))
                })
                .store(in: &self.subscriptions)
        }
    }
    
    func getPopular(page: Int = 1) {
        if let url = URLBuilder.getPopularMoviesURL(page: page) {
            self.networkManager.dataTask(url: url, type: MovieResponse.self)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure:
                        if let results = self.storeManager.selectMovies(by: .popular,
                                                                        page: page) {
                            self.store?.dispatch(MoviesAction.setPopular(results))
                        }
                    case .finished:
                        break
                    }
                }, receiveValue: { response in
                    let results = response.results.map { $0.build(categoryType: .popular) }
                    self.storeManager.insertMovies(movies: results)
                    self.store?.dispatch(MoviesAction.setPopular(results))
                })
                .store(in: &self.subscriptions)
        }
    }
    
    func getUpcoming(page: Int = 1) {
        if let url = URLBuilder.getUpcomingMoviesURL(page: page) {
            self.networkManager.dataTask(url: url, type: MovieResponse.self)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure:
                        if let results = self.storeManager.selectMovies(by: .upcoming,
                                                                        page: page) {
                            self.store?.dispatch(MoviesAction.setUpcoming(results))
                        }
                    case .finished:
                        break
                    }
                }, receiveValue: { response in
                    let results = response.results.map { $0.build(categoryType: .upcoming) }
                    self.storeManager.insertMovies(movies: results)
                    self.store?.dispatch(MoviesAction.setUpcoming(results))
                })
                .store(in: &self.subscriptions)
        }
    }
    
    func getFilteredMovies(text: String, page: Int = 1) {
        if let url = URLBuilder.searchMoviesURL(text: text, page: page) {
            self.networkManager.dataTask(url: url, type: MovieResponse.self)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure:
                        if let results = self.storeManager.selectMovies(by: text,
                                                                        page: page) {
                            self.store?.dispatch(MoviesAction.setFilteredMovies(results))
                        }
                    case .finished:
                        break
                    }
                }, receiveValue: { response in
                    self.storeManager.insertMovies(movies: response.results)
                    self.store?.dispatch(MoviesAction.setFilteredMovies(response.results))
                })
                .store(in: &self.subscriptions)
        }
    }
    
    func setImageData(movie: MovieResult) {
        self.storeManager.setMovieImageData(movie: movie)
    }
    
    func getImageData(movie: MovieResult, completion: ((Data) -> Void)? = nil) {
        completion?(self.storeManager.getMovieImageData(by: movie.id))
    }
    
    func getVideo(movieId: Int64, completion: ((_ videoId: String) -> Void)?) {
        if let url = URLBuilder.getVideoMovieURL(movieId: movieId) {
            self.networkManager.dataTask(url: url, type: VideoMovieResponse.self)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure:
                        break
                    case .finished:
                        break
                    }
                }, receiveValue: { response in
                    let videoId = response.results.last?.key ?? ""
                    completion?(videoId)
                    self.store?.dispatch(MoviesAction.setVideoId(videoId))
                })
                .store(in: &self.subscriptions)
        }
    }
    
}
