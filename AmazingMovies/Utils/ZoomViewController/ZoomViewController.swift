//
//  ZoomViewController.swift
//  AmazingMovies
//
//  Created by Ricardo Gehrke Filho on 27/07/19.
//  Copyright © 2019 Ricardo Gehrke Filho. All rights reserved.
//

import UIKit
import Kingfisher

class ZoomViewController: UIViewController, IdentifierLoadable, UIScrollViewDelegate {
    
    static func newInstance(url: URL) -> UIViewController {
        let viewController = UIStoryboard.loadViewController() as ZoomViewController
        viewController.url = url
        return viewController
    }
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    private var url: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        imageView.kf.setImage(with: url)
        
        navigationController?.navigationBar.barStyle = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "share"),
            style: .plain,
            target: self,
            action: #selector(shareButtonTapped))
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didDoubleTappedImage(tap:)))
        tap.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(tap)
    }
    
    @objc private func didDoubleTappedImage(tap: UITapGestureRecognizer) {
        if scrollView.zoomScale > 1 {
            scrollView.setZoomScale(1, animated: true)
        } else {
            let rect = CGRect(origin: tap.location(in: imageView), size: CGSize.zero)
            scrollView.zoom(to: rect, animated: true)
        }
    }
    
    @objc private func shareButtonTapped() {
        guard let image = imageView.image else { return }
        let viewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(viewController, animated: true)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
}
