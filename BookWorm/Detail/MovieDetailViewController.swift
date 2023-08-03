//
//  MovieDetailViewController.swift
//  BookWorm
//
//  Created by Eunbee Kang on 2023/07/31.
//

import UIKit

enum TransitionFrom {
    case main
    case browse
}

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
    let textNormalColor: UIColor = .black
    let textPlaceholderColor: UIColor = .systemGray
    
    var movie: Movie?
    var transitionFrom: TransitionFrom = .main
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        bottomTextView.delegate = self
        
        if transitionFrom == .browse {
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
        bottomTextView.textColor = textPlaceholderColor
    }
    
    func configXmark() {
        let xmark = UIImage(systemName: "xmark")
        let xmarkButton = UIBarButtonItem(image: xmark, style: .plain, target: self, action: #selector(dismissViewController))
        navigationItem.leftBarButtonItem = xmarkButton
    }
    
    func removePlaceholder() {
        bottomTextView.text = nil
        bottomTextView.textColor = textNormalColor
    }

    func setPlaceholder() {
        bottomTextView.text = placeholderText
        bottomTextView.textColor = textPlaceholderColor
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true)
    }
}

extension MovieDetailViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if bottomTextView.textColor == textPlaceholderColor {
            removePlaceholder()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if bottomTextView.text.isEmpty {
            setPlaceholder()
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if bottomTextView.textColor == textPlaceholderColor {
            bottomTextView.text = "\(bottomTextView.text.first!)"
            bottomTextView.textColor = textNormalColor
        }
        
        if bottomTextView.text.isEmpty {
            setPlaceholder()
            
            let cursorPosition = textView.beginningOfDocument
            textView.selectedTextRange = textView.textRange(from: cursorPosition, to: cursorPosition)
        }
    }
    
}
