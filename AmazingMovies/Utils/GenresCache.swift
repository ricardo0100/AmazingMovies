//
//  GenresCache.swift
//  AmazingMovies
//
//  Created by Ricardo Gehrke Filho on 26/07/19.
//  Copyright © 2019 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation

struct GenresCache {
    
    private static var genres: [Int: String] = [:]
    
    static var isLoaded: Bool {
        return GenresCache.genres.count > 0
    }
    
    static func update(with list: [Genre]) {
        list.forEach {
            GenresCache.genres[$0.id] = $0.name
        }
    }
    
    static func genreName(for id: Int) -> String {
        return GenresCache.genres[id] ?? ""
    }
    
}
