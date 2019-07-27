//
//  MainViewModel.swift
//  AmazingMovies
//
//  Created by Ricardo Gehrke Filho on 23/07/19.
//  Copyright © 2019 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation

protocol MainViewModelDelegate: class {
    func updateList(with movies: [FetchTrendingMoviesResponse.Movie])
    func setLayoutMode(mode: LayoutMode)
    func showMovieDetails(movie: FetchTrendingMoviesResponse.Movie)
}

enum LayoutMode {
    case grid, list
}

class MainViewModel {
    
    private let apiManager: APIManager
    private weak var delegate: MainViewModelDelegate?
    private var nextPage = 1
    private var isFetching = false
    private let throttler = Throttler(minimumDelay: 0.3)
    private var queryText: String = ""
    private var moviesList: [FetchTrendingMoviesResponse.Movie] = []
    
    init(delegate: MainViewModelDelegate, apiManager: APIManager) {
        self.delegate = delegate
        self.apiManager = apiManager
    }
    
    func onViewDidLoad() {
        delegate?.setLayoutMode(mode: .grid)
        isFetching = true
        apiManager.fetchTrendingMovies(page: nextPage) { [weak self] movies in
            self?.handleResults(movies: movies)
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
        if queryText.isEmpty {
            loadNextTrendingMoviesPage()
        } else {
            loadNextSearchPage()
        }
    }
    
    func onSearchTextChanged(text: String) {
        throttler.throttle { [weak self] in
            self?.queryText = text
            self?.nextPage = 1
            self?.loadNextSearchPage()
        }
    }
    
    func onSearchCanceled() {
        queryText = ""
        nextPage = 1
        loadNextTrendingMoviesPage()
    }
    
    private func loadNextTrendingMoviesPage() {
        apiManager.fetchTrendingMovies(page: nextPage) { [weak self] movies in
            self?.handleResults(movies: movies)
        }
    }
    
    private func loadNextSearchPage() {
        apiManager.searchMovies(query: queryText, page: nextPage, completion: { [weak self] movies in
            self?.handleResults(movies: movies)
        })
    }
    
    private func handleResults(movies: [FetchTrendingMoviesResponse.Movie]) {
        isFetching = false
        if nextPage == 1 {
            moviesList.removeAll()
        }
        nextPage += 1
        moviesList.append(contentsOf: movies)
        delegate?.updateList(with: moviesList)
    }
    
}
