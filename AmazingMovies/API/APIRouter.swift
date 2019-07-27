//
//  APIRouter.swift
//  AmazingMovies
//
//  Created by Ricardo Gehrke Filho on 24/07/19.
//  Copyright © 2019 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case Genres
    case Trending(page: Int)
    case Search(query: String, page: Int)
    
    var method: HTTPMethod {
        switch self {
        case .Genres, .Trending, .Search:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .Genres:
            return "/genre/movie/list"
        case .Trending:
            return "/trending/movie/day"
        case .Search:
            return "/search/movie"
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .Genres:
            return [:]
        case .Trending(let page):
            return ["page": page]
        case .Search(let query, let page):
            return ["page": page, "query": query]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.apiBaseUrl.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        var parameters = self.parameters
        parameters["api_key"] = Constants.apiToken
        
        urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        
        return urlRequest
    }
    
}
