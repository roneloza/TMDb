//
//  MovieVideoView.swift
//  TMDb
//
//  Created by Rone Shender on 29/11/21.
//

import SwiftUI
import PrograManiacsSwiftUI
import WebKit
import ReduxCore

struct YoutubeWebView : UIViewRepresentable {
    
    let videoId: String
    
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let embedHTML =
            """
        <iframe width="100%" height="100%" src="https://www.youtube.com/embed/\(videoId)?autoplay=1" title="YouTube video player" autoplay="1" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
        """
        uiView.loadHTMLString(embedHTML, baseURL: nil)
    }
    
}


struct MovieVideoView: View {
    
    weak var store: ReduxStore<MoviesState>? = nil
    @State private var videoId: String = ""
    let movie: MovieResult
    
    var body: some View {
        ZStack {
            YoutubeWebView(videoId: self.videoId)
        }
        .navigationBarTitle("Video", displayMode: .inline)
        .navigationBarHidden(false)
        .edgesIgnoringSafeArea(.all)
        .background(Color.black)
        .onAppear {
            self.store?.state.getVideo(movieId: self.movie.id, completion: { videoId in
                self.videoId = videoId
            })
        }
    }
    
}

struct MovieVideoView_Previews: PreviewProvider {
    static var previews: some View {
        MovieVideoView(movie: .init(id: 1,
                                    categoryType: .topRated,
                                    title: "Dilwale Dulhania Le Jayenge",
                                    releaseDate: "1995-10-20",
                                    imageUrl: "https://www.themoviedb.org/t/p/w220_and_h330_face/2CAL2433ZeIihfX1Hb2139CX0pW.jpg",
                                    overview: "A police brigade working in the dangerous northern neighborhoods of Marseille, where the level of crime is higher than anywhere else in France."))
    }
}
