//
//  MainViewController.swift
//  AmazingMovies
//
//  Created by Ricardo Gehrke Filho on 23/07/19.
//  Copyright © 2019 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit

class MainViewController: UICollectionViewController {

    private var viewModel: MainViewModel!
    private var moviesDataSource: [FetchTrendingMoviesResponse.Movie] = []
    private var selectedMode: LayoutMode = .grid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainViewModel(delegate: self, apiManager: APIManagerImplementation())
        viewModel.onViewDidLoad()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesDataSource.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = selectedMode == .list ? movieCell(for: indexPath) : posterCell(for: indexPath)
        return cell
    }
    
    private func posterCell(for indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as! PosterCollectionViewCell
        let movie = moviesDataSource[indexPath.item]
        cell.update(with: movie)
        return cell
    }
    
    private func movieCell(for indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
        let movie = moviesDataSource[indexPath.item]
        cell.update(with: movie)
        return cell
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
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
        if (bottomEdge >= scrollView.contentSize.height) {
            
        }
    }
    
}

extension MainViewController: MainViewModelDelegate {
    
    func appendMovies(movies: [FetchTrendingMoviesResponse.Movie]) {
        moviesDataSource.append(contentsOf: movies)
        collectionView.reloadData()
//        let nextIndex = moviesDataSource.count
//        moviesDataSource.append(contentsOf: movies)
//        collectionView.performBatchUpdates({
//            collectionView.insertItems(at: )
//        }) { (completed) in
//
//        }
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
}
