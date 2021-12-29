//
//  MovieDetailView.swift
//  TMDb
//
//  Created by Rone Shender on 24/11/21.
//

import SwiftUI
import ReduxCore
import PrograManiacsSwiftUI

struct MovieDetailView: View {
    
    private weak var useCase: MoviesUseCaseInput? = nil
    private let movie: MovieResult
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 16) {
                    ZStack {
                        ImageView(withURL: "\(TMDbConstants.Api.PosterURLString)\(self.movie.imageUrl)",
                                  completionGetImage: { imageView in
                                    self.useCase?.getImageData(
                                        movie: movie,
                                        completion: { data in
                                            imageView.setImage(UIImage(data: data) ?? UIImage())
                                        })
                                  },
                                  completionSetImage: { data in
                                    self.useCase?.setImageData(movie: movie.build(imageData: data))
                                  })
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(8)
                        NavigationLink(destination: MovieVideoView(useCase: self.useCase,
                                                                   movie: self.movie)) {
                            Image(systemName: "play.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                        }
                        .accentColor(.white)
                    }
                    VStack(spacing: 16) {
                        HStack{
                            Text(self.movie.title)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .font(.system(size: 24))
                                .fixedSize(horizontal: false, vertical: true)
                            Spacer()
                        }
                        HStack{
                            Text(self.movie.overview)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .font(.system(size: 16))
                                .fixedSize(horizontal: false, vertical: true)
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 16)
                    Spacer()
                }
            }
            .background(Color.black)
        }
        .navigationBarTitle(self.movie.title,
                            displayMode: .inline)
        .navigationBarHidden(false)
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            UIScrollView.appearance().backgroundColor = .clear
        }
    }
    
    init(useCase: MoviesUseCaseInput? = nil,
         movie: MovieResult) {
        self.useCase = useCase
        self.movie = movie
    }
    
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: .init(id: 1,
                                     categoryType: .topRated,
                                     title: "Dilwale Dulhania Le Jayenge",
                                     releaseDate: "1995-10-20",
                                     imageUrl: "https://www.themoviedb.org/t/p/w220_and_h330_face/2CAL2433ZeIihfX1Hb2139CX0pW.jpg",
                                     overview: "A police brigade working in the dangerous northern neighborhoods of Marseille, where the level of crime is higher than anywhere else in France."))
    }
}
