//
//  MovieResponse.swift
//  TMDb
//
//  Created by Rone Shender on 30/11/21.
//

import Foundation

struct MovieResponse: Codable {
    
    let results: [MovieResult]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
    
}
