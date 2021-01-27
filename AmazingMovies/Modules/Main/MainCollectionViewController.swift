//
//  MainCollectionViewController.swift
//  AmazingMovies
//
//  Created by Ricardo Gehrke Filho on 23/07/19.
//  Copyright © 2019 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit

class MainCollectionViewController: UICollectionViewController, IdentifierLoadable {

    static func newInstance() -> UIViewController {
        let viewController = UIStoryboard.loadViewController() as MainCollectionViewController
        viewController.viewModel = MainViewModel(delegate: viewController, apiManager: APIManagerImplementation())
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.barStyle = .black
        navigationController.navigationBar.tintColor = .white
        return navigationController
    }
    
    private var viewModel: MainViewModel?
    private var moviesDataSource: [Movie] = []
    private var selectedMode: LayoutMode = .grid

    private lazy var searchController: UISearchController = {
        var search = UISearchController(searchResultsController: nil)
        search.searchBar.delegate = self
        search.delegate = self
        search.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = search
        return search
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchButton()
        navigationItem.searchController = searchController
        viewModel?.onViewDidLoad()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesDataSource.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = selectedMode == .list ? movieCell(for: indexPath) : posterCell(for: indexPath)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath) {
        let movie = moviesDataSource[indexPath.item]
        viewModel?.onDidSelect(movie: movie)
    }
    
    private func posterCell(for indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath)
            // swiftlint:disable:next force_cast
            as! PosterCollectionViewCell
        let movie = moviesDataSource[indexPath.item]
        cell.update(with: movie)
        return cell
    }
    
    private func movieCell(for indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath)
            // swiftlint:disable:next force_cast
            as! MovieCollectionViewCell
        let movie = moviesDataSource[indexPath.item]
        cell.update(with: movie)
        return cell
    }
    
    private func setupSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "search"),
            style: .plain,
            target: self,
            action: #selector(didTapSearchButton))
    }
    
    @objc private func setGridFlowLayout() {
        let layout = UICollectionViewFlowLayout()
        let collectionViewWidth = collectionView.frame.width
        let numberOfColumns = collectionViewWidth > 320 ? 3 : 2
        let width = (collectionViewWidth / CGFloat(numberOfColumns)) - CGFloat((numberOfColumns - 1) * 1)
        layout.itemSize = CGSize(width: width, height: (40/27) * width)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        collectionView.setCollectionViewLayout(layout, animated: true)
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "view_list"),
            style: .plain,
            target: self,
            action: #selector(didTapListButton))
    }
    
    @objc private func didTapListButton() {
        viewModel?.onListButtonTapped()
    }
    
    @objc private func setListFlowLayout() {
        let layout = UICollectionViewFlowLayout()
        let collectionViewWidth = collectionView.frame.width
        layout.itemSize = CGSize(width: collectionViewWidth, height: 140)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 1
        collectionView.setCollectionViewLayout(layout, animated: true)
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "view_grid"),
            style: .plain,
            target: self,
            action: #selector(didTapGridLayoutButton))
    }
    
    @objc private func didTapGridLayoutButton() {
        viewModel?.onGridButtonTapped()
    }
    
    @objc private func didTapSearchButton() {
        searchController.isActive = true
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
        if bottomEdge >= scrollView.contentSize.height {
            viewModel?.onDidScrollToBottom()
        }
    }
    
}

extension MainCollectionViewController: UISearchBarDelegate, UISearchControllerDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.onSearchTextChanged(text: searchText)
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        viewModel?.onSearchCanceled()
    }
    
}

extension MainCollectionViewController: MainViewModelDelegate {
    
    func updateList(with movies: [Movie], scrollToTop: Bool) {
        moviesDataSource = movies
        collectionView.reloadData()
        if scrollToTop {
            collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        }
    }
    
    func setLayoutMode(mode: LayoutMode) {
        selectedMode = mode
        collectionView.reloadData()
        if mode == .grid {
            setGridFlowLayout()
        } else {
            setListFlowLayout()
        }
    }
    
    func showMovieDetails(movie: Movie) {
        let detailsViewController = DetailsViewController.newInstance(movie: movie)
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    func showError(message: String) {
        showAlert(title: "ERROR_TITLE".localized(), message: message)
    }
    
    func activityIndicator(isShowing: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = isShowing
    }
}
