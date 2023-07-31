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
    
    func configCell() {
        cellBackgroundView.layer.cornerRadius = 16
        cellBackgroundView.clipsToBounds = true
        
        movieTitleLabel.textColor = .white
        rateLabel.textColor = .white
    }
    
}
