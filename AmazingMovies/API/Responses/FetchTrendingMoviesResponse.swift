//
//  FetchTrendingMoviesResponse.swift
//  AmazingMovies
//
//  Created by Ricardo Gehrke Filho on 25/07/19.
//  Copyright © 2019 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation

struct FetchTrendingMoviesResponse: Codable {
    
    let results: [Movie]
    let page: Int
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case results
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    struct Movie: Codable {
        let id: Int
        let title: String
        let overview: String
        let posterPath: String
        let backdropPath: String
        let popularity: Float
        
        enum CodingKeys: String, CodingKey {
            case id
            case title
            case overview
            case posterPath = "poster_path"
            case backdropPath = "backdrop_path"
            case popularity
        }
        
        var posterURL: URL? {
            let url = URL(string: "https://image.tmdb.org/t/p/w500" + posterPath)
            return url
        }
        
        var backdropURL: URL? {
            let url = URL(string: "https://image.tmdb.org/t/p/w500" + backdropPath)
            return url
        }
        
    }
    
}
