//
//  MoviesMiddlewareStub.swift
//  TMDb
//
//  Created by Rone Shender on 30/11/21.
//

import ReduxCore
import Foundation
import Combine

final class MoviesMiddlewareStub: MoviesMiddlewareDatasource {
    
    private let result: Result<Data, Error>
    private var subscriptions = Set<AnyCancellable>()
    private lazy var networkManager: NetworkManager = {
        URLSessionNetworkManagerStub(returning: self.result)
    }()
    private lazy var decodeManager: DecodeManager = {
        JsonDecodeManager()
    }()
    var results: [MovieResult] = []
    var videoMovieResult: VideoMovieResult = .init(key: "")
    
    init(returning result: Result<Data, Error>) {
        self.result = result
    }
    
    // MARK: MoviesMiddlewareDatasource
    
    func getTopRated(page: Int = 1) {
        if let url = URLBuilder.getTopRatedMoviesURL(page: page) {
            self.networkManager.dataTask(url: url)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure:
                        break
                    case .finished:
                        break
                    }
                }, receiveValue: { data in
                    guard let response = self.decodeManager.decode(data: data, type: MovieResponse.self) else {
                        return
                    }
                    self.results = response.results.map { $0.build(categoryType: .topRated) }
                })
                .store(in: &self.subscriptions)
        }
    }
    
    func getPopular(page: Int = 1) {
        if let url = URLBuilder.getPopularMoviesURL(page: page) {
            self.networkManager.dataTask(url: url)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure:
                        break
                    case .finished:
                        break
                    }
                }, receiveValue: { data in
                    guard let response = self.decodeManager.decode(data: data, type: MovieResponse.self) else {
                        return
                    }
                    self.results = response.results.map { $0.build(categoryType: .popular) }
                })
                .store(in: &self.subscriptions)
        }
    }
    
    func getUpcoming(page: Int = 1) {
        if let url = URLBuilder.getUpcomingMoviesURL(page: page) {
            self.networkManager.dataTask(url: url)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure:
                        break
                    case .finished:
                        break
                    }
                }, receiveValue: { data in
                    guard let response = self.decodeManager.decode(data: data, type: MovieResponse.self) else {
                        return
                    }
                    self.results = response.results.map { $0.build(categoryType: .upcoming) }
                })
                .store(in: &self.subscriptions)
        }
    }
    
    func getFilteredMovies(text: String, page: Int = 1) {
        if let url = URLBuilder.searchMoviesURL(text: text, page: page) {
            self.networkManager.dataTask(url: url)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure:
                        break
                    case .finished:
                        break
                    }
                }, receiveValue: { data in
                    guard let response = self.decodeManager.decode(data: data, type: MovieResponse.self) else {
                        return
                    }
                    self.results = response.results
                })
                .store(in: &self.subscriptions)
        }
    }
    
    func setImageData(movie: MovieResult) {
        print("setMovieImageData")
    }
    
    func getImageData(movie: MovieResult, completion: ((Data) -> Void)? = nil) {
        print("getMovieImageData")
    }
    
    func getVideo(movieId: Int64, completion: ((_ videoId: String) -> Void)?) {
        if let url = URLBuilder.getVideoMovieURL(movieId: movieId) {
            self.networkManager.dataTask(url: url)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .failure:
                        break
                    case .finished:
                        break
                    }
                }, receiveValue: { data in
                    guard let response = self.decodeManager.decode(data: data, type: VideoMovieResponse.self) else {
                        return
                    }
                    let videoId = response.results.last?.key ?? ""
                    completion?(videoId)
                    self.videoMovieResult = response.results.last ?? self.videoMovieResult
                })
                .store(in: &self.subscriptions)
        }
    }
    
}
