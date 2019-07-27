//
//  MainViewModel.swift
//  AmazingMovies
//
//  Created by Ricardo Gehrke Filho on 23/07/19.
//  Copyright © 2019 Ricardo Gehrke Filho. All rights reserved.
//

import Foundation

protocol MainViewModelDelegate: class {
    func updateList(with movies: [Movie], scrollToTop: Bool)
    func setLayoutMode(mode: LayoutMode)
    func showMovieDetails(movie: Movie)
    func showError(message: String)
}

enum LayoutMode: Int {
    case grid = 1
    case list = 2
    
    static func mode(from rawValue: Int) -> LayoutMode? {
        switch rawValue {
        case LayoutMode.list.rawValue:
            return .list
        case LayoutMode.grid.rawValue:
            return .grid
        default:
            return nil
        }
    }
}

class MainViewModel {
    
    private let apiManager: APIManager
    private weak var delegate: MainViewModelDelegate?
    private var nextPage = 1
    private var isFetching = false
    private let throttler = Throttler(minimumDelay: 0.3)
    private var queryText: String = ""
    private var moviesList: [Movie] = []
    
    init(delegate: MainViewModelDelegate, apiManager: APIManager) {
        self.delegate = delegate
        self.apiManager = apiManager
    }
    
    func onViewDidLoad() {
        let modeId = UserDefaults.standard.integer(forKey: Constants.layoutModeUserDefaultsKey)
        let layoutMode = LayoutMode.mode(from: modeId)
        delegate?.setLayoutMode(mode: layoutMode ?? .grid)
        isFetching = true
        loadNextTrendingMoviesPage()
    }
    
    func onListButtonTapped() {
        delegate?.setLayoutMode(mode: .list)
        UserDefaults.standard.set(LayoutMode.list.rawValue, forKey: Constants.layoutModeUserDefaultsKey)
    }
    
    func onGridButtonTapped() {
        delegate?.setLayoutMode(mode: .grid)
        UserDefaults.standard.set(LayoutMode.grid.rawValue, forKey: Constants.layoutModeUserDefaultsKey)
    }
    
    func onDidSelect(movie: Movie) {
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
        apiManager.fetchUpcomingMovies(page: nextPage, completion: { [weak self] movies in
            self?.handleResults(movies: movies)
            }, onError: { [weak self] _ in
                self?.delegate?.showError(message: "FETCH_TRENDING_ERROR".localized())
            })
    }
    
    private func loadNextSearchPage() {
        apiManager.searchMovies(query: queryText, page: nextPage, completion: { [weak self] movies in
            self?.handleResults(movies: movies)
            }, onError: { [weak self] _ in
                self?.delegate?.showError(message: "SEARCH_ERROR".localized())
            })
    }
    
    private func handleResults(movies: [Movie]) {
        isFetching = false
        if nextPage == 1 {
            moviesList.removeAll()
        }
        nextPage += 1
        moviesList.append(contentsOf: movies)
        delegate?.updateList(with: moviesList, scrollToTop: nextPage == 2)
    }
    
}
