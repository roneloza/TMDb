//
//  MovieCategory.swift
//  TMDb
//
//  Created by Rone Shender on 30/11/21.
//

import Foundation

struct MovieCategory: Identifiable {
    
    let id: MovieCategoryType
    let movies: [MovieResult]
    
    init(id: MovieCategoryType,
         movies: [MovieResult]) {
        self.id = id
        self.movies = movies
    }
    
    func build(id: MovieCategoryType? = nil,
               movies: [MovieResult]? = nil) -> MovieCategory {
        .init(id: id ?? self.id,
              movies: movies ?? self.movies)
    }
    
}
