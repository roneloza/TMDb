//
//  MovieResult.swift
//  TMDb
//
//  Created by Rone Shender on 30/11/21.
//

import Foundation

struct MovieResult: Codable, Identifiable {
    
    let id: Int64
    var categoryType: MovieCategoryType = .topRated
    var categoryTypes: [String] = []
    let title: String
    let releaseDate: String
    let imageUrl: String
    var imageData: Data = Data()
    let overview: String
    let youTubeKey: String? = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseDate = "release_date"
        case imageUrl = "poster_path"
        case overview
        case youTubeKey
    }
    
    init(id: Int64,
         categoryType: MovieCategoryType = .topRated,
         title: String = "",
         releaseDate: String = "",
         imageUrl: String = "",
         imageData: Data? = nil,
         overview: String = "",
         youTubeKey: String? = nil,
         categoryTypes: [String] = [""]) {
        self.id = id
        self.title = title
        self.releaseDate = releaseDate
        self.imageUrl = imageUrl
        self.overview = overview
        self.imageData = imageData ?? Data()
        self.categoryType = categoryType
        self.categoryTypes = categoryTypes
    }
    
    func build(id: Int64? = nil,
               categoryType: MovieCategoryType? = nil,
               title: String? = nil,
               releaseDate: String? = nil,
               imageUrl: String? = nil,
               imageData: Data? = nil,
               overview: String? = nil,
               youTubeKey: String? = nil,
               categoryTypes: [String]? = nil) -> MovieResult {
        .init(id: id ?? self.id,
              categoryType: categoryType ?? self.categoryType,
              title: title ?? self.title,
              releaseDate: releaseDate ?? self.releaseDate,
              imageUrl: imageUrl ?? self.imageUrl,
              imageData: imageData ?? self.imageData,
              overview: overview ?? self.overview,
              youTubeKey: youTubeKey ?? self.youTubeKey,
              categoryTypes: categoryTypes ?? self.categoryTypes)
    }
    
}
