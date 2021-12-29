//
//  TMDbApp.swift
//  TMDb
//
//  Created by Rone Shender on 24/11/21.
//

import SwiftUI

@main
struct TMDbApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            MoviesView(presenter: .init(
                state: .init(
                    model: MoviesStateModel(categories: [
                        .init(id: MovieCategoryType.topRated,
                              movies: []),
                        .init(id: MovieCategoryType.popular,
                              movies: []),
                        .init(id: MovieCategoryType.upcoming,
                              movies: [])
                    ]))))
        }
    }
    
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print(NSHomeDirectory())
        return true
    }
    
}
