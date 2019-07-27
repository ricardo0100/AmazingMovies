//
//  String+Extensions.swift
//  AmazingMovies
//
//  Created by Ricardo Gehrke Filho on 27/07/19.
//  Copyright © 2019 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation

extension String {
    
    func asDate(with format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
    
    func localized() -> String {
        return NSLocalizedString(self, comment: self)
    }
    
}
