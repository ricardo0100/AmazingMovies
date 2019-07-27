//
//  APIManager.swift
//  AmazingMovies
//
//  Created by Ricardo Gehrke Filho on 24/07/19.
//  Copyright © 2019 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation
import Alamofire

protocol APIManager {
    func fetchTrendingMovies(page: Int, completion: @escaping ([Movie]) -> Void)
    func searchMovies(query: String, page: Int, completion: @escaping ([Movie]) -> Void)
}

struct APIManagerImplementation: APIManager {
    
    func fetchTrendingMovies(page: Int, completion: @escaping ([Movie]) -> Void) {
        AF.request(APIRouter.Trending(page: page))
            .responseDecodable { (response: DataResponse<MoviesListResponse>) in
                if let error = response.error {
                    print("Error fetching trending movies: \(error)")
                }
                guard var movies = response.value?.results else { return }
                movies.sort(by: { (movie1, movie2) -> Bool in
                    return movie1.popularity > movie2.popularity
                })
                completion(movies)
        }
    }
    
    func searchMovies(query: String, page: Int, completion: @escaping ([Movie]) -> Void) {
        AF.request(APIRouter.Search(query: query, page: page))
            .responseDecodable { (response: DataResponse<MoviesListResponse>) in
                if let error = response.error {
                    print("Error fetching trending movies: \(error)")
                }
                guard var movies = response.value?.results else { return }
                movies.sort(by: { (movie1, movie2) -> Bool in
                    return movie1.popularity > movie2.popularity
                })
                completion(movies)
        }
    }
    
}
