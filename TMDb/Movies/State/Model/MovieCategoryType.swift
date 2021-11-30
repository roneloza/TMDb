//
//  MovieCategoryType.swift
//  TMDb
//
//  Created by Rone Shender on 30/11/21.
//

import Foundation

enum MovieCategoryType: Int, Codable {
    
    case topRated = 1,
         popular = 2,
         upcoming = 3
    
    var title: String {
        switch self {
        case .topRated:
            return "Top Rated"
        case .popular:
            return "Popular"
        case .upcoming:
            return "Upcoming"
        }
    }
    
}
