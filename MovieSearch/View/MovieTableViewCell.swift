//
//  MovieTableViewCell.swift
//  MovieSearch
//
//  Created by G JAdarsh on 23/09/18.
//  Copyright © 2018 G JAdarsh. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieTableViewCell: UITableViewCell, IdentifiableCell {

    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    
    var movie: Movie? {
        didSet {
            movieNameLabel.text = movie?.movieName
            movieReleaseDateLabel.text = movie?.movieReleaseDate
            movieOverviewLabel.text = movie?.movieOverview
            if let imagePath = movie?.moviePosterPath, let posterImageURL = URL(string: (AppConstants.URLs.imageBaseURL + imagePath)) {
                moviePosterImageView.af_setImage(withURL: posterImageURL)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        moviePosterImageView.image = nil
        movieNameLabel.text = nil
        movieOverviewLabel.text = nil
        movieReleaseDateLabel.text = nil
    }
}
