//
//  NetworkManager.swift
//  TMDb
//
//  Created by Rone Shender on 25/11/21.
//

import Foundation
import Combine

protocol NetworkManager {
    
    func dataTask<T: Decodable>(url: URL?, type: T.Type) -> Future<T, Error>
    
}


final class URLSessionNetworkManager: NetworkManager {
    
    private lazy var decodeManager: DecodeManager = {
        JsonDecodeManager()
    }()
    
    func dataTask<T: Decodable>(url: URL?, type: T.Type) -> Future<T, Error> {
        Future<T, Error> { promise in
            if let url = url {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    if let error = error {
                        promise(.failure(error))
                    } else {
                        if let data = self.decodeManager.decode(data: data, type: T.self) {
                            promise(.success(data))
                        } else {
                            promise(.failure(NSError(domain: "Empty Data", code: 100, userInfo: nil)))
                        }
                    }
                }
                task.resume()
            }
        }
    }
    
}
