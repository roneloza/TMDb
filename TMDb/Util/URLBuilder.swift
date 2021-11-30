//
//  File.swift
//  TMDb
//
//  Created by Rone Shender on 25/11/21.
//

import Foundation

struct URLBuilder {
    
    static func getTopRatedMoviesURL(page: Int = 1) -> URL? {
        let queryItems = [
            URLQueryItem(name: TMDbConstants.ParameterKeys.ApiKey, value: TMDbConstants.ParameterValues.ApiKey),
            URLQueryItem(name: TMDbConstants.ParameterKeys.Page, value: "\(page)")
        ]
        var urlComps = URLComponents(string: TMDbConstants.Api.BaseURLString)!
        urlComps.path = TMDbConstants.Methods.SearchTopRatedMovies
        urlComps.queryItems = queryItems
        return urlComps.url!
    }
    
    static func getPopularMoviesURL(page: Int = 1) -> URL? {
        let queryItems = [
            URLQueryItem(name: TMDbConstants.ParameterKeys.ApiKey, value: TMDbConstants.ParameterValues.ApiKey),
            URLQueryItem(name: TMDbConstants.ParameterKeys.Page, value: "\(page)")
        ]
        var urlComps = URLComponents(string: TMDbConstants.Api.BaseURLString)!
        urlComps.path = TMDbConstants.Methods.SearchPopularMovies
        urlComps.queryItems = queryItems
        return urlComps.url!
    }
    
    static func getUpcomingMoviesURL(page: Int = 1) -> URL? {
        let queryItems = [
            URLQueryItem(name: TMDbConstants.ParameterKeys.ApiKey, value: TMDbConstants.ParameterValues.ApiKey),
            URLQueryItem(name: TMDbConstants.ParameterKeys.Page, value: "\(page)")
        ]
        var urlComps = URLComponents(string: TMDbConstants.Api.BaseURLString)!
        urlComps.path = TMDbConstants.Methods.SearchUpcomingMovies
        urlComps.queryItems = queryItems
        return urlComps.url!
    }
    
    static func searchMoviesURL(text: String, page: Int = 1) -> URL? {
        let queryItems = [
            URLQueryItem(name: TMDbConstants.ParameterKeys.ApiKey, value: TMDbConstants.ParameterValues.ApiKey),
            URLQueryItem(name: TMDbConstants.ParameterKeys.Page, value: "\(page)"),
            URLQueryItem(name: TMDbConstants.ParameterKeys.Query, value: text)
        ]
        var urlComps = URLComponents(string: TMDbConstants.Api.BaseURLString)!
        urlComps.path = TMDbConstants.Methods.SearchTextMovie
        urlComps.queryItems = queryItems
        return urlComps.url!
    }
    
    static func getVideoMovieURL(movieId: Int64) -> URL? {
        let queryItems = [
            URLQueryItem(name: TMDbConstants.ParameterKeys.ApiKey, value: TMDbConstants.ParameterValues.ApiKey),
        ]
        var urlComps = URLComponents(string: TMDbConstants.Api.BaseURLString)!
        urlComps.path = String(format: TMDbConstants.Methods.SearchVideo, movieId)
        urlComps.queryItems = queryItems
        return urlComps.url!
    }
    
}
