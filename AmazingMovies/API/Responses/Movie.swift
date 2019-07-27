//
//  Movie.swift
//  AmazingMovies
//
//  Created by Ricardo Gehrke Filho on 26/07/19.
//  Copyright © 2019 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let popularity: Float
    let genreIds: [Int]
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case popularity
        case genreIds = "genre_ids"
        case releaseDate = "release_date"
    }
    
    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        let url = URL(string: "https://image.tmdb.org/t/p/w500" + path)
        return url
    }
    
    var backdropURL: URL? {
        guard let path = backdropPath else { return nil }
        let url = URL(string: "https://image.tmdb.org/t/p/w500" + path)
        return url
    }
    
}
