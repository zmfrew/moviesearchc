//
//  MovieTableViewCell.swift
//  MovieSearchC
//
//  Created by Zachary Frew on 7/24/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratinglabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Properties
    var movie: ZMFMovie? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Methods
    func updateViews() {
        guard let movie = movie else { return }
        
        titleLabel.text = movie.title
        ratinglabel.text = "\(movie.rating)"
        descriptionLabel.text = movie.movieDescription
        
        ZMFMovieController.shared().retrieveImage(for: movie) { (image) in
            DispatchQueue.main.async {
                self.movieImageView.image = image
            }
        }
    }
    
    
}
