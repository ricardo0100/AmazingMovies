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
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var zoomIconImageView: UIImageView!
    @IBOutlet private weak var posterTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var posterIconImageView: UIImageView!
    @IBOutlet weak var noPosterLabel: UILabel!
    
    private var viewModel: DetailsViewModel?
    
    static func newInstance(movie: Movie) -> DetailsViewController {
        let viewController = UIStoryboard.loadViewController() as DetailsViewController
        viewController.viewModel = DetailsViewModel(delegate: viewController, movie: movie)
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPosterButton()
        viewModel?.onViewDidLoad()
    }
    
    private func setupPosterButton() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapPosterButton))
        posterImageView.addGestureRecognizer(tap)
        
        zoomIconImageView.image = zoomIconImageView.image?.withRenderingMode(.alwaysTemplate)
        zoomIconImageView.tintColor = .white
        zoomIconImageView.tintColorDidChange()
        
        posterIconImageView.image = posterIconImageView.image?.withRenderingMode(.alwaysTemplate)
        posterIconImageView.tintColor = .white
        posterIconImageView.tintColorDidChange()
    }
    
    @objc private func didTapPosterButton() {
        viewModel?.onPosterTapped()
    }
    
}

extension DetailsViewController: DetailsViewModelDelegate {
    
    func update(with movie: Movie) {
        titleLabel.text = movie.title
        if movie.backdropURL != nil {
            backdropImageView.kf.setImage(with: movie.backdropURL)
        } else {
            posterTopConstraint.constant = 24
            titleTopConstraint.constant = 24
        }
        if movie.posterURL != nil {
            posterImageView.kf.setImage(with: movie.posterURL)
        } else {
            posterImageView.layer.borderWidth = 1
            posterImageView.layer.borderColor = UIColor.white.cgColor
            zoomIconImageView.isHidden = true
            noPosterLabel.isHidden = false
            posterIconImageView.isHidden = false
        }
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
        releaseLabel.text = date.toDateString()
    }
    
    func showZoomForImage(in url: URL) {
        let zoomViewController = ZoomViewController.newInstance(url: url)
        navigationController?.pushViewController(zoomViewController, animated: true)
    }
    
}
