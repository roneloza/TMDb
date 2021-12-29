//
//  MoviesState.swift
//  TMDb
//
//  Created by Rone Shender on 24/11/21.
//

import ReduxCore
import Foundation

struct MoviesState: ReduxState, Hashable {
    
    let id: String = UUID().uuidString
    var model: MoviesStateData
    
    init(model: MoviesStateData = MoviesStateModel()) {
        self.model = model
    }
    
    func build(model: MoviesStateData? = nil) -> MoviesState {
        .init(model: model ?? self.model)
    }
    
    func buildCategories(data: [MovieResult],
                         id: MovieCategoryType,
                         page: Int) -> [MovieCategory] {
        guard let index = self.model.categories.lastIndex(where: { $0.id == id }),
              let category = self.model.categories.filter({ $0.id == id }).last else { return [] }
        var movies = category.movies
        if page > 1 {
            movies.append(contentsOf: data)
        } else {
            movies = data
        }
        var categories = self.model.categories
        categories[index] = category.build(movies: movies)
        return categories
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    static func == (lhs: MoviesState, rhs: MoviesState) -> Bool {
        return lhs.id == rhs.id
    }
    
}
