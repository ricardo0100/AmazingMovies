//
//  PosterCollectionViewCell.swift
//  AmazingMovies
//
//  Created by Ricardo Gehrke Filho on 26/07/19.
//  Copyright © 2019 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit
import Kingfisher

class PosterCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PosterCell"
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func prepareForReuse() {
        titleLabel.text = nil
        titleLabel.isHidden = true
        imageView.image = nil
        imageView.isHidden = false
    }
    
    func update(with movie: Movie) {
        if movie.posterURL == nil {
            imageView.isHidden = true
            titleLabel.isHidden = false
            titleLabel.text = "📸\n(No poster)\n\n\(movie.title)"
        } else {
            imageView.kf.setImage(with: movie.posterURL)
        }
    }
    
}
