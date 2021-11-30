//
//  MoviesViewAction.swift
//  TMDb
//
//  Created by Rone Shender on 24/11/21.
//

import ReduxCore
import Foundation

enum MoviesAction: ReduxAction {
    
    case getTopRated(page: Int)
    case setTopRated([MovieResult])
    case getPopular(page: Int)
    case setPopular([MovieResult])
    case getUpcoming(page: Int)
    case setUpcoming([MovieResult])
    case setImageData(movie: MovieResult)
    case getImageData(movie: MovieResult, completion: ((Data) -> Void)? = nil)
    case getFilteredMovies(text: String, page: Int)
    case setFilteredMovies([MovieResult])
    case getVideo(movieId: Int64, completion: ((_ videoId: String) -> Void)?)
    case setVideoId(_ videoId: String)
    
}
