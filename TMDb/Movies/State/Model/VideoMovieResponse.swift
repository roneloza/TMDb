//
//  VideoMovieResponse.swift
//  TMDb
//
//  Created by Rone Shender on 30/11/21.
//

import Foundation

struct VideoMovieResult: Codable {
    
    let key: String
    
    enum CodingKeys: String, CodingKey {
        case key
    }
    
}

struct VideoMovieResponse: Codable {
    
    let results: [VideoMovieResult]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
    
}
