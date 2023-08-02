//
//  BrowseTableViewCell.swift
//  BookWorm
//
//  Created by Eunbee Kang on 2023/08/02.
//

import UIKit

class BrowseTableViewCell: UITableViewCell {
    
    static let identifier = "BrowseTableViewCell"
    
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var likeButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        configUI()
    }
    
    func configCellData(row: Movie) {
        posterImageView.image = UIImage(named: row.title)
        movieTitleLabel.text = row.title
        infoLabel.text = "\(row.releaseDate) • \(row.runtime)분"
        rateLabel.text = "⭐️ \(row.rate)"
        
        let likeImage = row.isLiked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        likeButton.setImage(likeImage, for: .normal)
        
        likeButton.tintColor = row.isLiked ? .systemRed : .systemGray
    }
    
    func configUI() {
        movieTitleLabel.font = .preferredFont(forTextStyle: .headline)
        posterImageView.contentMode = .scaleAspectFill
    }
}
