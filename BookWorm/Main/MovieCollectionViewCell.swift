//
//  MovieCollectionViewCell.swift
//  BookWorm
//
//  Created by Eunbee Kang on 2023/07/31.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    static let identifier = "MovieCollectionViewCell"
    
    @IBOutlet var cellBackgroundView: UIView!
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    
    func configCell(item: Movie) {
        cellBackgroundView.layer.cornerRadius = 16
        cellBackgroundView.clipsToBounds = true
        
        movieTitleLabel.textColor = .white
        rateLabel.textColor = .white
        
        movieTitleLabel.text = item.title
        posterImageView.image = UIImage(named: item.title)
        rateLabel.text = String(item.rate)
        
        let likeImage = item.isLiked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        likeButton.setImage(likeImage, for: .normal)
    }
    
}
