//
//  MoviesStateData.swift
//  TMDb
//
//  Created by Rone Shender on 6/12/21.
//

import Foundation
import ReduxCore

protocol MoviesStateData {
    
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
    var videoId: String { get }
    
    func build(categories: [MovieCategory]?,
               topRatedPage: Int?,
               topRatedIsLoading: Bool?,
               popularPage: Int?,
               popularIsLoading: Bool?,
               upcomingPage: Int?,
               upcomingIsLoading: Bool?,
               searchText: String?,
               movies: [MovieResult]?,
               searchPage: Int?,
               searchIsLoading: Bool?,
               videoId: String?) -> MoviesStateData
}

extension MoviesStateData {
    
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
               videoId: String? = nil) -> MoviesStateData {
        self.build(categories: categories ?? self.categories,
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
                   videoId: videoId ?? self.videoId)
    }
}

struct MoviesStateModel: MoviesStateData {
    
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
         videoId: String = "") {
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
               videoId: String? = nil) -> MoviesStateData {
        MoviesStateModel(categories: categories ?? self.categories,
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
                         videoId: videoId ?? self.videoId)
    }
    
}
