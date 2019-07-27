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
    func fetchUpcomingMovies(page: Int, completion: @escaping ([Movie]) -> Void, onError: ((Error) -> Void)?)
    func searchMovies(query: String, page: Int, completion: @escaping ([Movie]) -> Void, onError: ((Error) -> Void)?)
    func fetchGenres(completion: @escaping ([Genre]) -> Void, onError: ((Error) -> Void)?)
}

struct APIManagerImplementation: APIManager {
    
    func fetchUpcomingMovies(page: Int, completion: @escaping ([Movie]) -> Void, onError: ((Error) -> Void)? = nil) {
        AF.request(APIRouter.upcoming(page: page))
            .responseDecodable { (response: DataResponse<MoviesListResponse>) in
                if let error = response.error {
                    print("Error fetching upcoming movies: \(error)")
                    onError?(error)
                }
                guard let movies = response.value?.results else {
                    onError?(NSError(domain: "Error fetching upcoming movies", code: 0, userInfo: nil))
                    return
                }
                completion(movies)
        }
    }
    
    func searchMovies(query: String,
                      page: Int,
                      completion: @escaping ([Movie]) -> Void,
                      onError: ((Error) -> Void)? = nil) {
        AF.request(APIRouter.search(query: query, page: page))
            .responseDecodable { (response: DataResponse<MoviesListResponse>) in
                if let error = response.error {
                    print("Error searching movies: \(error)")
                    onError?(error)
                }
                guard let movies = response.value?.results else {
                    onError?(NSError(domain: "Error searching movies", code: 0, userInfo: nil))
                    return
                }
                completion(movies)
        }
    }
    
    func fetchGenres(completion: @escaping ([Genre]) -> Void, onError: ((Error) -> Void)? = nil) {
        AF.request(APIRouter.genres)
            .responseDecodable { (response: DataResponse<GenresListResponse>) in
                if let error = response.error {
                    print("Error fetching genres: \(error)")
                    onError?(error)
                }
                guard let genres = response.value?.genres else { return }
                completion(genres)
        }
    }
    
}
