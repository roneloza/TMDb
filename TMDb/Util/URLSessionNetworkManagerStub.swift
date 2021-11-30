//
//  URLSessionNetworkManagerStub.swift
//  TMDb
//
//  Created by Rone Shender on 30/11/21.
//

import Foundation
import Combine

final class URLSessionNetworkManagerStub: NetworkManager {
    
    private let result: Result<Data, Error>

    init(returning result: Result<Data, Error>) {
        self.result = result
    }
    
    func dataTask(url: URL?) -> Future<Data, Error> {
        Future { promise in
            promise(self.result)
        }
    }
    
}
