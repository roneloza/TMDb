//
//  TMDbConstants.swift
//  TMDb
//
//  Created by Rone Shender on 24/11/21.
//

import Foundation

struct TMDbConstants {
    
    struct Api {
        
        static let Key = "0942529e191d0558f888245403b4dca7"
        static let BaseURLString = "https://api.themoviedb.org"
        static let YouTubeBaseURLString = "https://www.youtube.com/watch?v="
        static let PosterURLString = "https://www.themoviedb.org/t/p/w220_and_h330_face"
        
    }
    
    struct Methods {
        
        static let SearchPopularMovies = "/3/movie/popular"
        static let SearchTopRatedMovies = "/3/movie/top_rated"
        static let SearchUpcomingMovies = "/3/movie/upcoming"
        static let SearchMovie = "/3/movie/"
        static let SearchVideo = "/3/movie/%i/videos"
        static let SearchTextMovie = "/3/search/movie"
        
    }
    
    struct ParameterKeys {
        
        static let ApiKey = "api_key"
        static let Language = "language"
        static let Page = "page"
        static let Query = "query"
        
    }
    
    struct ParameterValues {
        
        static let ApiKey = "0942529e191d0558f888245403b4dca7"
        static let Language = "en-US"
        
    }
    
}
