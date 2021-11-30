//
//  MovieResultTest.swift
//  TMDbTests
//
//  Created by Rone Shender on 30/11/21.
//

import XCTest
@testable import TMDb

class MovieResultTest: XCTestCase {
    
    // MARK: Simpler check example
    // Use this option if your models match the shape of the input JSON.
    func testWhenDecodedFromJSONDataToMovieResultNotNil() throws {
        let json = #"{"adult":false,"backdrop_path":"/iNh3BivHyg5sQRPP1KOkzguEX0H.jpg","genre_ids":[18,80],"id":278,"original_language":"en","original_title":"The Shawshank Redemption","overview":"Framed in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.","popularity":52.637,"poster_path":"/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg","release_date":"1994-09-23","title":"The Shawshank Redemption","video":false,"vote_average":8.7,"vote_count":20197}"#
        let data = try XCTUnwrap(json.data(using: .utf8))
        XCTAssertNotNil(JsonDecodeManager().decode(data: data, type: MovieResult.self))
    }
    
    func testWhenDecodedFromJSONDataToMovieResult() throws {
        let json = #"{"adult":false,"backdrop_path":"/iNh3BivHyg5sQRPP1KOkzguEX0H.jpg","genre_ids":[18,80],"id":278,"original_language":"en","original_title":"The Shawshank Redemption","overview":"Framed in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.","popularity":52.637,"poster_path":"/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg","release_date":"1994-09-23","title":"The Shawshank Redemption","video":false,"vote_average":8.7,"vote_count":20197}"#
        let data = try XCTUnwrap(json.data(using: .utf8))
        guard let item = JsonDecodeManager().decode(data: data, type: MovieResult.self) else {
            XCTFail("return empty object")
            return
        }
        XCTAssertEqual(item.id, 278)
        XCTAssertEqual(item.title, "The Shawshank Redemption")
        XCTAssertEqual(item.releaseDate, "1994-09-23")
        XCTAssertEqual(item.imageUrl, "/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg")
        XCTAssertEqual(item.overview, "Framed in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.")
    }
    
    func testWhenDecodedFromJSONFileToMovieResult() throws {
        let data = try dataFromJSONFileNamed("movie")
        guard let item = JsonDecodeManager().decode(data: data, type: MovieResult.self) else {
            XCTFail("return empty object")
            return
        }
        XCTAssertEqual(item.id, 238)
        XCTAssertEqual(item.title, "The Godfather")
        XCTAssertEqual(item.releaseDate, "1972-03-14")
        XCTAssertEqual(item.imageUrl, "/eEslKSwcqmiNS6va24Pbxf2UKmJ.jpg")
        XCTAssertEqual(item.overview, "Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge.")
    }
    
}
