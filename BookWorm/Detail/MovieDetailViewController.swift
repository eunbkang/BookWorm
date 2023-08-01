//
//  MovieDetailViewController.swift
//  BookWorm
//
//  Created by Eunbee Kang on 2023/07/31.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet var posterBackgroundImageView: UIImageView!
    @IBOutlet var posterImageView: UIImageView!
    
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    
    @IBOutlet var likeButton: UIButton!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }

    func configUI() {
        guard let movie = movie else {
            return
        }
        
        let poster = UIImage(named: movie.title)
        posterBackgroundImageView.image = poster
        posterImageView.image = poster
        
        posterImageView.configShadow()
        
        movieTitleLabel.text = movie.title
        descriptionLabel.text = movie.overview
        rateLabel.text = "⭐️ \(movie.rate)"
        infoLabel.text = "\(movie.releaseDate) • \(movie.runtime)분"
        
        let likeImage = movie.isLiked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        likeButton.setImage(likeImage, for: .normal)
        
        if !movie.isLiked {
            likeButton.tintColor = .systemGray
        }
    }
}

