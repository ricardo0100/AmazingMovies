//
//  DetailsViewController.swift
//  AmazingMovies
//
//  Created by Ricardo Gehrke Filho on 26/07/19.
//  Copyright © 2019 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit
import Kingfisher

class DetailsViewController: UIViewController, IdentifierLoadable {
    
    @IBOutlet private weak var backdropImageView: UIImageView!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var overviewLabel: UILabel!
    
    private var viewModel: DetailsViewModel?
    
    static func newInstance(movie: FetchTrendingMoviesResponse.Movie) -> DetailsViewController {
        let viewController = UIStoryboard.loadViewController() as DetailsViewController
        viewController.viewModel = DetailsViewModel(delegate: viewController, movie: movie)
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.onViewDidLoad()
    }
    
}

extension DetailsViewController: DetailsViewModelDelegate {
    
    func update(with movie: FetchTrendingMoviesResponse.Movie) {
        title = movie.title
        backdropImageView.kf.setImage(with: movie.backdropURL)
        posterImageView.kf.setImage(with: movie.posterURL)
        overviewLabel.text = movie.overview
    }
    
}
