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
    @IBOutlet private weak var genresLabel: UILabel!
    @IBOutlet private weak var releaseLabel: UILabel!
    
    private var viewModel: DetailsViewModel?
    
    static func newInstance(movie: Movie) -> DetailsViewController {
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
    
    func update(with movie: Movie) {
        title = movie.title
        backdropImageView.kf.setImage(with: movie.backdropURL)
        posterImageView.kf.setImage(with: movie.posterURL)
        overviewLabel.text = movie.overview
    }
    
    func update(with genres: String) {
        genresLabel.text = genres
    }
    
    func update(with releaseDate: Date?) {
        guard let date = releaseDate else {
            releaseLabel.text = nil
            return
        }
        releaseLabel.text = date.toString(with: "yyyy")
    }
    
}
