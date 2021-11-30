//
//  DecoderManager.swift
//  TMDb
//
//  Created by Rone Shender on 24/11/21.
//

import Foundation
import SQLite

protocol StoreManagerMovie {
    
    func insertMovies(movies: [MovieResult])
    func updateMovies(movies: [MovieResult])
    func selectMovies(by id: Int64) -> [MovieResult]?
    func selectMovies(by category: MovieCategoryType, page: Int) -> [MovieResult]?
    func selectMovies(by title: String, page: Int) -> [MovieResult]?
    func getMovieImageData(by id: Int64) -> Data
    func setMovieImageData(movie: MovieResult)
    
}

final class SQLiteStoreManagerMovie: StoreManagerMovie {
    
    init() {
        self.setup()
    }
    
    func setup() {
        do {
            let db = try Connection("\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/Database.db")
            let movieTable = Table("Movie")
            let id = Expression<Int64>("id")
            let title = Expression<String?>("title")
            let releaseDate = Expression<String>("releaseDate")
            let imageUrl = Expression<String>("imageUrl")
            let imageBlob = Expression<Blob>("imageBlob")
            let overview = Expression<String>("overview")
            let youTubeKey = Expression<String>("youTubeKey")
            let categoryId = Expression<String>("categoryType")
            
            try db.run(movieTable.create { t in
                t.column(id, primaryKey: true)
                t.column(title)
                t.column(releaseDate)
                t.column(imageUrl)
                t.column(imageBlob)
                t.column(overview)
                t.column(youTubeKey)
                t.column(categoryId)
            })
        } catch {
            print(error)
        }
    }
    
    // MARK: - StoreManager -
    
    func insertMovies(movies: [MovieResult]) {
        do {
            let db = try Connection("\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/Database.db")
            let stmt = try db.prepare("INSERT INTO Movie (id, title, releaseDate, imageUrl, overview, youTubeKey, categoryType) VALUES (?, ?, ?, ?, ?, ?, ?)")
            for movie in movies {
                if let categoryType = try? db.scalar("SELECT categoryType FROM Movie WHERE id = \(movie.id)") as? String {
                    var categories = categoryType.split(separator: ",").map(String.init)
                    categories.append(movie.categoryType.rawValue.description)
                    let newMovie = movie.build(categoryTypes: Array(Set(categories)))
                    self.updateMovies(movies: [newMovie])
                } else {
                    try stmt.run(movie.id,
                                 movie.title,
                                 movie.releaseDate,
                                 movie.imageUrl,
                                 movie.overview,
                                 movie.youTubeKey,
                                 movie.categoryType.rawValue.description)
                }
            }
        } catch {
            print(error)
        }
    }
    
    func updateMovies(movies: [MovieResult]) {
        do {
            let db = try Connection("\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/Database.db")
            let stmt = try db.prepare("UPDATE Movie SET title = ?, releaseDate = ?, imageUrl = ?, overview = ?, youTubeKey = ?, categoryType = ? WHERE id = ?")
            for movie in movies {
                try stmt.run(movie.title,
                             movie.releaseDate,
                             movie.imageUrl,
                             movie.overview,
                             movie.youTubeKey,
                             movie.categoryTypes.joined(separator: ","),
                             movie.id)
            }
        } catch {
            print(error)
        }
    }
    
    func selectMovies(by id: Int64) -> [MovieResult]? {
        var movies: [MovieResult] = []
        do {
            let db = try Connection("\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/Database.db")
            for row in try db.prepare("SELECT id, title, releaseDate, imageUrl, overview, youTubeKey FROM Movie WHERE id = \(id) ORDER BY rowid LIMIT 1") {
                movies.append(.init(id: row[0] as? Int64 ?? 0,
                                    title: row[0] as? String ?? "",
                                    releaseDate: row[0] as? String ?? "",
                                    imageUrl: row[0] as? String ?? "",
                                    overview: row[0] as? String ?? "",
                                    youTubeKey: row[0] as? String ?? ""))
            }
        } catch {
            print(error)
        }
        return movies
    }
    
    func selectMovies(by category: MovieCategoryType, page: Int = 1) -> [MovieResult]? {
        var movies: [MovieResult] = []
        do {
            let db = try Connection("\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/Database.db")
            for row in try db.prepare("SELECT id, title, releaseDate, imageUrl, overview, youTubeKey FROM Movie WHERE categoryType LIKE '%\(category.rawValue)%' ORDER BY rowid LIMIT 20 OFFSET (20 * \(page) - 20)") {
                movies.append(.init(id: row[0] as? Int64 ?? 0,
                                    title: row[1] as? String ?? "",
                                    releaseDate: row[2] as? String ?? "",
                                    imageUrl: row[3] as? String ?? "",
                                    overview: row[4] as? String ?? "",
                                    youTubeKey: row[5] as? String ?? ""))
            }
        } catch {
            print(error)
        }
        return movies
    }
    
    func selectMovies(by title: String, page: Int = 1) -> [MovieResult]? {
        var movies: [MovieResult] = []
        do {
            let db = try Connection("\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/Database.db")
            for row in try db.prepare("SELECT id, title, releaseDate, imageUrl, overview, youTubeKey FROM Movie WHERE title LIKE '%\(title)%' ORDER BY rowid LIMIT 20 OFFSET (20 * \(page) - 20)") {
                movies.append(.init(id: row[0] as? Int64 ?? 0,
                                    title: row[1] as? String ?? "",
                                    releaseDate: row[2] as? String ?? "",
                                    imageUrl: row[3] as? String ?? "",
                                    overview: row[4] as? String ?? "",
                                    youTubeKey: row[5] as? String ?? ""))
            }
        } catch {
            print(error)
        }
        return movies
    }
    
    func getMovieImageData(by id: Int64) -> Data {
        var imageData: Data = Data()
        do {
            let db = try Connection("\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/Database.db")
            for row in try db.prepare("SELECT imageBlob FROM Movie WHERE id = \(id) ORDER BY rowid LIMIT 1") {
                if let blob = (row[0] as? Blob) {
                    imageData = Data(bytes: blob.bytes, count: blob.bytes.count)
                }
            }
        } catch {
            print(error)
        }
        return imageData
    }
    
    func setMovieImageData(movie: MovieResult) {
        do {
            let db = try Connection("\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/Database.db")
            let stmt = try db.prepare("UPDATE Movie SET imageBlob = ? WHERE id = ?")
            let data = (movie.imageData as NSData)
            try stmt.run(Blob(bytes: data.bytes, length: data.count),
                         movie.id)
        } catch {
            print(error)
        }
    }
    
}
