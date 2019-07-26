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
    
    static let baseURL = "https://api.themoviedb.org/3"
    static let apiKey = "1f54bd990f1cdfb230adb312546d765d"
    
    case Trending(page: Int)
    
    var method: HTTPMethod {
        switch self {
        case .Trending:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .Trending:
            return "/trending/movie/day"
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .Trending(let page):
            return ["page": page]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try APIRouter.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        var parameters = self.parameters
        parameters["api_key"] = APIRouter.apiKey
        
        switch self {
        case .Trending:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
    
}
