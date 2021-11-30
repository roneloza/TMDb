//
//  NetworkManagerTest.swift
//  TMDbTests
//
//  Created by Rone Shender on 30/11/21.
//

import XCTest
import Combine
@testable import TMDb

class NetworkManagerTest: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()
    
    func testWhenRequestSucceedsPublishesDecodedMovieResponse() throws {
        let json = """
    {
        "page": 1,
        "results": [
            {
                "adult": false,
                "backdrop_path": "/iNh3BivHyg5sQRPP1KOkzguEX0H.jpg",
                "genre_ids": [
                    18,
                    80
                ],
                "id": 278,
                "original_language": "en",
                "original_title": "The Shawshank Redemption",
                "overview": "Framed in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.",
                "popularity": 52.637,
                "poster_path": "/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg",
                "release_date": "1994-09-23",
                "title": "The Shawshank Redemption",
                "video": false,
                "vote_average": 8.7,
                "vote_count": 20197
            },
            {
                "adult": false,
                "backdrop_path": "/rSPw7tgCH9c6NqICZef4kZjFOQ5.jpg",
                "genre_ids": [
                    18,
                    80
                ],
                "id": 238,
                "original_language": "en",
                "original_title": "The Godfather",
                "overview": "Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge.",
                "popularity": 53.306,
                "poster_path": "/eEslKSwcqmiNS6va24Pbxf2UKmJ.jpg",
                "release_date": "1972-03-14",
                "title": "The Godfather",
                "video": false,
                "vote_average": 8.7,
                "vote_count": 15124
            }
        ],
        "total_pages": 469,
        "total_results": 9375
    }
    """
        let data = try XCTUnwrap(json.data(using: .utf8))
        let moviesMiddleware = MoviesMiddlewareStub(returning: .success(data))
        let expectation = XCTestExpectation(description: "Publishes decoded MovieResponse")
        moviesMiddleware.getTopRated()
        XCTAssertEqual(moviesMiddleware.results.count, 2)
        XCTAssertEqual(moviesMiddleware.results.first?.title, "The Shawshank Redemption")
        XCTAssertEqual(moviesMiddleware.results.last?.title, "The Godfather")
        expectation.fulfill()
        wait(for: [expectation], timeout: 1)
    }
    
}
