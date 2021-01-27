//
//  Constants.swift
//  AmazingMovies
//
//  Created by Ricardo Gehrke Filho on 26/07/19.
//  Copyright © 2019 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation

struct Constants {
    static let apiDateFormat = "yyyy-MM-dd"
    static let layoutModeUserDefaultsKey = "LayoutMode"
    static var apiBaseUrl: String {
        return Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as? String ?? ""
    }
    static var apiToken: String {
        return Bundle.main.object(forInfoDictionaryKey: "API_TOKEN") as? String ?? ""
    }
    static var imageBaseUrl: String {
        return Bundle.main.object(forInfoDictionaryKey: "IMAGE_BASE_URL") as? String ?? ""
    }
}
