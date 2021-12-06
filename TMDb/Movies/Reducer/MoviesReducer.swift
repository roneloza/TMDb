//
//  MoviesReducer.swift
//  TMDb
//
//  Created by Rone Shender on 24/11/21.
//

import ReduxCore

final class MoviesReducer: ReduxReducer<MoviesState> {
    
    override func reduce(state: MoviesState, action: ReduxAction) -> MoviesState {
        switch action {
        case let MoviesAction.setTopRated(data):
            return state.build(model: state.model.build(categories: self.buildCategories(state: state,
                                                                                        data: data,
                                                                                        id: MovieCategoryType.topRated,
                                                                                        page: state.model.topRatedPage),
                                                       topRatedIsLoading: false))
        case let MoviesAction.setPopular(data):
            return state.build(model: state.model.build(categories: self.buildCategories(state: state,
                                                                                        data: data,
                                                                                        id: MovieCategoryType.popular,
                                                                                        page: state.model.popularPage),
                                                       popularIsLoading: false))
        case let MoviesAction.setUpcoming(data):
            return state.build(model: state.model.build(categories: self.buildCategories(state: state,
                                                                                        data: data,
                                                                                        id: MovieCategoryType.upcoming,
                                                                                        page: state.model.upcomingPage),
                                                       upcomingIsLoading: false))
        case let MoviesAction.setFilteredMovies(data):
            var movies = state.model.movies
            if state.model.searchPage > 1 {
                movies.append(contentsOf: data)
            } else {
                movies = data
            }
            return state.build(model: state.model.build(movies: movies,
                                                       searchIsLoading: false))
        case let MoviesAction.setVideoId(videoId):
            return state.build(model: state.model.build(videoId: videoId))
        default:
            return state
        }
    }
    
    private func buildCategories(state: MoviesState,
                                 data: [MovieResult],
                                 id: MovieCategoryType,
                                 page: Int) -> [MovieCategory] {
        guard let index = state.model.categories.lastIndex(where: { $0.id == id }),
              let category = state.model.categories.filter({ $0.id == id }).last else { return  [] }
        var movies = category.movies
        if page > 1 {
            movies.append(contentsOf: data)
        } else {
            movies = data
        }
        var categories = state.model.categories
        categories[index] = category.build(movies: movies)
        return categories
    }
    
}
