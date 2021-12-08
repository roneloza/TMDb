//
//  ContentView.swift
//  TMDb
//
//  Created by Rone Shender on 24/11/21.
//

import SwiftUI
import ReduxCore
import PrograManiacsSwiftUI

struct MoviesView: ReduxStoreView {
    
    @ObservedObject private(set) var store: ReduxStore<MoviesState>
    private var useCase: MoviesUseCaseInput
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    SearchBar(text: self.$store.state.model.searchText.onChange({ text in
                        self.useCase.getFilteredMovies(text: text,
                                                       page: 1)
                    }))
                    if !self.store.state.model.searchText.isEmpty {
                        List {
                            ForEach(self.store.state.model.movies) { movie in
                                NavigationLink(destination:
                                                MovieDetailView(useCase: self.useCase,
                                                                movie: movie)) {
                                    MovieCellView(useCase: self.useCase,
                                                  movie: movie)
                                        .frame(height: 100)
                                        .onAppear {
                                            self.useCase.getFilteredMoviesPagination(item: movie)
                                        }
                                }
                            }
                            .accessibilityLabel("searchMoviesList")
                            .accessibilityIdentifier("searchMoviesList")
                        }
                    } else {
                        List {
                            LazyVStack {
                                ForEach(self.store.state.model.categories) { category in
                                    Section(header:
                                                Text(category.id.title)
                                                .foregroundColor(.black)
                                                .fontWeight(.bold)
                                                .font(.system(size: 20))
                                    ) {
                                        ScrollView(.horizontal) {
                                            LazyHStack(spacing: 20) {
                                                ForEach(category.movies) { movie in
                                                    NavigationLink(destination:
                                                                    MovieDetailView(useCase: self.useCase,
                                                                                    movie: movie)) {
                                                        MovieCardView(useCase: self.useCase,
                                                                      movie: movie)
                                                            .onAppear {
                                                                switch category.id {
                                                                case .topRated:
                                                                    self.useCase.getTopRatedPagination(item: movie)
                                                                case .popular:
                                                                    self.useCase.getPopularPagination(item: movie)
                                                                case .upcoming:
                                                                    self.useCase.getUpcomingPagination(item: movie)
                                                                }
                                                            }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    .accentColor(.black)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("TMDb")
        }
        .background(Color.white)
        .onAppear {
            UITableView.appearance().backgroundColor = .clear
            self.useCase.getTopRated(page: 1)
            self.useCase.getPopular(page: 1)
            self.useCase.getUpcoming(page: 1)
        }
    }
    
    init(store: ReduxStore<MoviesState>) {
        self.store = store
        self.useCase = MoviesStateUseCase(store: store,
                                          presenter: MoviesStatePresenter(store: store))
        self.store.addMiddleware(middleware: MoviesMiddleware(presenter: self.useCase.presenter))
    }
    
}

struct MoviesView_Previews: PreviewProvider {
    static let store = ReduxStore<MoviesState>(
        state:
            .init(model: MoviesStateModel(categories: [
                .init(id: .topRated,
                      movies: [
                        .init(id: 1,
                              categoryType: .topRated,
                              title: "Dilwale Dulhania Le Jayenge",
                              releaseDate: "1995-10-20",
                              imageUrl: "https://www.themoviedb.org/t/p/w220_and_h330_face/2CAL2433ZeIihfX1Hb2139CX0pW.jpg",
                              overview: "A police brigade working in the dangerous northern neighborhoods of Marseille, where the level of crime is higher than anywhere else in France.")
                      ]),
                .init(id: .popular,
                      movies: [
                        .init(id: 1,
                              categoryType: .popular,
                              title: "Dilwale Dulhania Le Jayenge",
                              releaseDate: "1995-10-20",
                              imageUrl: "https://www.themoviedb.org/t/p/w220_and_h330_face/2CAL2433ZeIihfX1Hb2139CX0pW.jpg",
                              overview: "A police brigade working in the dangerous northern neighborhoods of Marseille, where the level of crime is higher than anywhere else in France.")
                      ])
            ])),
        reducer: MoviesReducer())
    static var previews: some View {
        MoviesView(store: self.store)
    }
}
