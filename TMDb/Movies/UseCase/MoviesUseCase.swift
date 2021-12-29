//
//  MoviesUseCase.swift
//  TMDb
//
//  Created by Rone Shender on 6/12/21.
//

import Foundation
import ReduxCore
import SwiftUI

protocol MoviesUseCaseOutput: AnyObject {
    
    var state: MoviesState { get set }
    
    func setTopRated(_ results: [MovieResult])
    func setPopular(_ results: [MovieResult])
    func setUpcoming(_ results: [MovieResult])
    func setFilteredMovies(_ results: [MovieResult])
    func setVideoId(_ videoId: String)
    
}

extension MoviesUseCaseOutput {
    
    var state: MoviesState {
        get { MoviesState() }
        set { _ = newValue}
    }
    
}

protocol MoviesUseCaseInput: AnyObject {
    
    var presenter: MoviesUseCaseOutput? { get }
    
    func getTopRated(page: Int)
    func getTopRatedPagination(item: MovieResult)
    func getPopular(page: Int)
    func getPopularPagination(item: MovieResult)
    func getUpcoming(page: Int)
    func getUpcomingPagination(item: MovieResult)
    func getFilteredMovies(text: String, page: Int)
    func getFilteredMoviesPagination(item: MovieResult)
    func getImageData(movie: MovieResult, completion: ((Data) -> Void)?)
    func getVideo(movieId: Int64, completion: ((_ videoId: String) -> Void)?)
    func setImageData(movie: MovieResult)
    
}

extension MoviesUseCaseOutput {
    
    var presenter: MoviesUseCaseOutput? { nil }
    
}
