//
//  MoviesListResponse.swift
//  AmazingMovies
//
//  Created by Ricardo Gehrke Filho on 25/07/19.
//  Copyright © 2019 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation

struct MoviesListResponse: Codable {
    
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
    
}
