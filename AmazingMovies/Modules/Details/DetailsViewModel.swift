//
//  DetailsViewModel.swift
//  AmazingMovies
//
//  Created by Ricardo Gehrke Filho on 26/07/19.
//  Copyright © 2019 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation

protocol DetailsViewModelDelegate: class {
    func update(with movie: Movie)
    func update(with genres: String)
    func update(with releaseDate: Date?)
    func showZoomForImage(in url: URL)
}

class DetailsViewModel {
    
    private let delegate: DetailsViewModelDelegate
    private let movie: Movie
    
    init(delegate: DetailsViewModelDelegate, movie: Movie) {
        self.delegate = delegate
        self.movie = movie
    }
    
    func onViewDidLoad() {
        delegate.update(with: movie)
        let genres: [String] = movie.genreIds.map { id -> String in
            return GenresCache.genreName(for: id)
        }
        delegate.update(with: movie.releaseDate.asDate(with: Constants.apiDateFormat))
        delegate.update(with: genres.joined(separator: ", "))
    }
    
    func onPosterTapped() {
        guard let url = movie.posterURL else { return }
        delegate.showZoomForImage(in: url)
    }
    
}
