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
    
    @ObservedObject var store: ReduxStore<MoviesState>
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    SearchBar(text: self.$store.state.searchText.onChange({ text in
                        self.store.state.getFilteredMovies(text: text,
                                                           page: 1)
                    }))
                    if !self.store.state.searchText.isEmpty {
                        List {
                            ForEach(self.store.state.movies) { movie in
                                NavigationLink(destination:
                                                MovieDetailView(store: self.store,
                                                                            movie: movie)) {
                                    MovieCellView(store: self.store,
                                                  movie: movie)
                                        .frame(height: 100)
                                        .onAppear {
                                            self.store.state.getFilteredMoviesPagination(item: movie)
                                        }
                                }
                            }
                            .accessibilityLabel("searchMoviesList")
                            .accessibilityIdentifier("searchMoviesList")
                        }
                    } else {
                        List {
                            LazyVStack {
                                ForEach(self.store.state.categories) { category in
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
                                                                    MovieDetailView(store: self.store,
                                                                                                movie: movie)) {
                                                        MovieCardView(store:self.store,
                                                                      movie: movie)
                                                            .onAppear {
                                                                switch category.id {
                                                                case .topRated:
                                                                    self.store.state.getTopRatedPagination(item: movie)
                                                                case .popular:
                                                                    self.store.state.getPopularPagination(item: movie)
                                                                case .upcoming:
                                                                    self.store.state.getUpcomingPagination(item: movie)
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
            self.store.state.getTopRated(page: 1)
            self.store.state.getPopular(page: 1)
            self.store.state.getUpcoming(page: 1)
        }
    }
    
    internal init(store: ReduxStore<MoviesState>) {
        self.store = store
        self.store.state.store = self.store
    }
    
}

struct MoviesView_Previews: PreviewProvider {
    static let store = ReduxStore<MoviesState>(
        state:
            .init(categories: [
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
            ]),
        reducer: MoviesReducer())
    static var previews: some View {
        MoviesView(store: self.store)
    }
}
