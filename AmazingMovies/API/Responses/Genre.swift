//
//  Genre.swift
//  AmazingMovies
//
//  Created by Ricardo Gehrke Filho on 26/07/19.
//  Copyright © 2019 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation

class Genre: Codable {
    let genreId: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case genreId = "id"
        case name
    }
}
