//
//  DetailsViewModel.swift
//  AmazingMovies
//
//  Created by Ricardo Gehrke Filho on 26/07/19.
//  Copyright © 2019 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation

protocol DetailsViewModelDelegate: class {
    func update(with movie: FetchTrendingMoviesResponse.Movie)
}

class DetailsViewModel {
    
    private let delegate: DetailsViewModelDelegate
    private let movie: FetchTrendingMoviesResponse.Movie
    
    init(delegate: DetailsViewModelDelegate, movie: FetchTrendingMoviesResponse.Movie) {
        self.delegate = delegate
        self.movie = movie
    }
    
    func onViewDidLoad() {
        delegate.update(with: movie)
    }
    
}
