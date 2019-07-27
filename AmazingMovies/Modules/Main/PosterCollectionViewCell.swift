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
    
    func update(with movie: Movie) {
        imageView.kf.setImage(with: movie.posterURL)
    }
    
}
