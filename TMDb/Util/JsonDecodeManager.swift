//
//  CacheManager.swift
//  TMDb
//
//  Created by Rone Shender on 24/11/21.
//

import Foundation

protocol DecodeManager {
    
    func decode<T: Decodable>(data: Data?, type: T.Type) -> T?
    
}


final class JsonDecodeManager: DecodeManager {
    
    func decode<T: Decodable>(data: Data?, type: T.Type) -> T? {
        if let data = data,
           let decodeObject = try? JSONDecoder().decode(T.self, from: data) {
            return decodeObject
        }
        return nil
    }
    
}
