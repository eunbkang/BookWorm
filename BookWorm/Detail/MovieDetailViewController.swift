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
    
    @IBOutlet var bottomTextView: UITextView!
    
    let placeholderText = "내용을 입력하세요."
    
    var movie: Movie?
    var isModal: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        bottomTextView.delegate = self
        
        if isModal {
            configXmark()
        }
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
        
        bottomTextView.text = placeholderText
        bottomTextView.textColor = .systemGray
    }
    
    func configXmark() {
        let xmark = UIImage(systemName: "xmark")
        let xmarkButton = UIBarButtonItem(image: xmark, style: .plain, target: self, action: #selector(dismissViewController))
        navigationItem.leftBarButtonItem = xmarkButton
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true)
    }
}

extension MovieDetailViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if bottomTextView.text == placeholderText {
            bottomTextView.text = nil
            bottomTextView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if bottomTextView.text.isEmpty {
            bottomTextView.text = placeholderText
            bottomTextView.textColor = .systemGray
        }
    }
    
    
}
