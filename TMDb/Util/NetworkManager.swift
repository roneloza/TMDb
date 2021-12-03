//
//  NetworkManager.swift
//  TMDb
//
//  Created by Rone Shender on 25/11/21.
//

import Foundation
import Combine

protocol NetworkManager {
    
    func dataTask(url: URL?) -> Future<Data, Error>
    
}


final class URLSessionNetworkManager: NetworkManager {
    
    func dataTask(url: URL?) -> Future<Data, Error> {
        Future { promise in
            if let url = url {
                print(url)
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    if let error = error {
                        promise(.failure(error))
                    } else {
                        if let data = data {
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
