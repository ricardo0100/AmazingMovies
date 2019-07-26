//
//  MainViewModel.swift
//  AmazingMovies
//
//  Created by Ricardo Gehrke Filho on 23/07/19.
//  Copyright © 2019 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation

protocol MainViewModelDelegate: class {
    func appendMovies(movies: [FetchTrendingMoviesResponse.Movie])
    func setLayoutMode(mode: LayoutMode)
    func showMovieDetails(movie: FetchTrendingMoviesResponse.Movie)
}

enum LayoutMode {
    case grid, list
}

class MainViewModel {
    
    private let apiManager: APIManager
    private weak var delegate: MainViewModelDelegate?
    private var page = 1
    private var isFetching = false
    
    init(delegate: MainViewModelDelegate, apiManager: APIManager) {
        self.delegate = delegate
        self.apiManager = apiManager
    }
    
    func onViewDidLoad() {
        delegate?.setLayoutMode(mode: .grid)
        isFetching = true
        apiManager.fetchTrendingMovies(page: page) { [weak self] movies in
            self?.isFetching = false
            self?.page += 1
            self?.delegate?.appendMovies(movies: movies)
        }
    }
    
    func onListButtonTapped() {
        delegate?.setLayoutMode(mode: .list)
    }
    
    func onGridButtonTapped() {
        delegate?.setLayoutMode(mode: .grid)
    }
    
    func onDidSelect(movie: FetchTrendingMoviesResponse.Movie) {
        delegate?.showMovieDetails(movie: movie)
    }
    
    func onDidScrollToBottom() {
        if isFetching { return }
        isFetching = true
        apiManager.fetchTrendingMovies(page: page) { [weak self] movies in
            self?.isFetching = false
            self?.page += 1
            self?.delegate?.appendMovies(movies: movies)
        }
    }
    
}
