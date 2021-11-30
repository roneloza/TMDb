//
//  XCTestCase+JSON.swift
//  TMDbTests
//
//  Created by Rone Shender on 30/11/21.
//

import XCTest

extension XCTestCase {

    func dataFromJSONFileNamed(_ name: String) throws -> Data {
        let url = try XCTUnwrap(
            Bundle(for: type(of: self)).url(forResource: name, withExtension: "json")
        )
        return try Data(contentsOf: url)
    }
}
