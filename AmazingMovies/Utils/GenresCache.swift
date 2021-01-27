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
            GenresCache.genres[$0.genreId] = $0.name
        }
    }
    
    static func genreName(for genreId: Int) -> String {
        return GenresCache.genres[genreId] ?? ""
    }
    
}
