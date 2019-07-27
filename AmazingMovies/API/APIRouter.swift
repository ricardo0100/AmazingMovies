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
    
    case genres
    case upcoming(page: Int)
    case search(query: String, page: Int)
    
    var method: HTTPMethod {
        switch self {
        case .genres, .upcoming, .search:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .genres:
            return "/genre/movie/list"
        case .upcoming:
            return "/discover/movie"
        case .search:
            return "/search/movie"
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .genres:
            return [:]
        case .upcoming(let page):
            let startDate = Date().toString(with: Constants.apiDateFormat)
            let endDate = (Calendar.current.date(byAdding: .year, value: 1, to: Date()) ?? Date())
                .toString(with: Constants.apiDateFormat)
            return ["page": page,
                    "primary_release_date.gte": startDate,
                    "primary_release_date.lte": endDate]
        case .search(let query, let page):
            return ["page": page,
                    "query": query]
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
