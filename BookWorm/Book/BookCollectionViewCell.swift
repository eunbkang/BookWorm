//
//  BookCollectionViewCell.swift
//  BookWorm
//
//  Created by Eunbee Kang on 2023/08/09.
//

import UIKit
import Kingfisher

final class BookCollectionViewCell: UICollectionViewCell {
    static let identifier = "BookCollectionViewCell"
    
    @IBOutlet var cellBackgroundView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configUI()
    }

    func configCell(item: Book) {
        titleLabel.text = item.title
        authorLabel.text = item.author
        priceLabel.text = "₩\(makeIntToWonString(int: item.price))"

        if let url = URL(string: item.thumbnail) {
            thumbnailImageView.kf.setImage(with: url)
        }
    }
    
    func configCellFromTable(item: BookTable) {
        titleLabel.text = item.title
        authorLabel.text = item.author
        priceLabel.text = "₩\(makeIntToWonString(int: item.price))"
    }
    
    func configUI() {
        cellBackgroundView.layer.cornerRadius = 16
        cellBackgroundView.clipsToBounds = true
        
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 2
        
        authorLabel.textColor = .white
        authorLabel.numberOfLines = 2
        
        priceLabel.textColor = .white
        
        thumbnailImageView.configShadow()
    }
    
    func makeIntToWonString(int: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(for: int)!
    }
}
