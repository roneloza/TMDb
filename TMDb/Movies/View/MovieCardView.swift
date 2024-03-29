//
//  MovieCardView.swift
//  TMDb
//
//  Created by Rone Shender on 24/11/21.
//

import SwiftUI
import Combine
import ReduxCore
import PrograManiacsSwiftUI

struct MovieCardView: View {
    
    private weak var useCase: MoviesUseCaseInput? = nil
    private let movie: MovieResult
    
    var body: some View {
        VStack {
            ImageView(withURL: "\(TMDbConstants.Api.PosterURLString)\(self.movie.imageUrl)",
                      completionGetImage: { imageView in
                        self.useCase?.getImageData(
                            movie: movie,
                            completion: { data in
                                imageView.setImage(UIImage(data: data) ?? UIImage())
                            })
                      },
                      completionSetImage: { data in
                        self.useCase?.presenter?.setImageData(movie: movie.build(imageData: data))
                      })
                .aspectRatio(contentMode: .fit)
                .cornerRadius(8)
            HStack{
                Text(self.movie.title)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .font(.system(size: 14))
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(width: 150, alignment: .leading)
                Spacer()
            }
        }
    }
    
    init(useCase: MoviesUseCaseInput? = nil,
         movie: MovieResult) {
        self.useCase = useCase
        self.movie = movie
    }
    
}

struct MovieCardView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCardView(movie: .init(id: 1,
                                   categoryType: .topRated,
                                   title: "Dilwale Dulhania Le Jayenge",
                                   releaseDate: "1995-10-20",
                                   imageUrl: "https://www.themoviedb.org/t/p/w220_and_h330_face/2CAL2433ZeIihfX1Hb2139CX0pW.jpg",
                                   overview: "A police brigade working in the dangerous northern neighborhoods of Marseille, where the level of crime is higher than anywhere else in France."))
    }
}
