//
//  MovieCollectionViewCell.swift
//  AmazingMovies
//
//  Created by Ricardo Gehrke Filho on 26/07/19.
//  Copyright © 2019 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MovieCell"
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UILabel!
    @IBOutlet private weak var releaseLabel: UILabel!
    
    func update(with movie: Movie) {
        imageView.kf.setImage(with: movie.posterURL)
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        let releaseYear = movie.releaseDate.asDate(with: Constants.apiDateFormat)?.toString(with: "yyyy")
        releaseLabel.text = releaseYear
    }
    
}
