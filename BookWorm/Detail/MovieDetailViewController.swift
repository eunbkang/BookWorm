//
//  MovieDetailViewController.swift
//  BookWorm
//
//  Created by Eunbee Kang on 2023/07/31.
//

import UIKit
//import RealmSwift

enum TransitionFrom {
    case main
    case browse
}

final class MovieDetailViewController: UIViewController {
    
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
    
    var book: BookTable?
    
//    let realm = try! Realm()
    let repository = BookTableRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomTextView.delegate = self
        
        if transitionFrom == .browse {
            configXmark()
        }
        
        posterImageView.configShadow()
        
        setBookToView()
        configNavigationBarItem()
    }
    
    @objc func tappedEditButton() {
//        do {
//            try realm.write {
//                book?.review = bottomTextView.text
//
//                realm.create(BookTable.self, value: ["_id": book?._id, "review": book?.review], update: .modified)
//            }
//        } catch {
//            print("update erorr")
//        }
        
        guard let book = book else { return }
        
        repository.updateBook(id: book._id, review: bottomTextView.text)
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc func tappedDeleteButton() {
        guard let book = book else { return }

        removeImageFromDocument(fileName: "book_\(book._id).jpg")
        
        repository.delete(book)
        
        navigationController?.popViewController(animated: true)
    }
    
    func configNavigationBarItem() {
        let editButton = UIBarButtonItem(title: "수정", style: .plain, target: self, action: #selector(tappedEditButton))
        let deleteButton = UIBarButtonItem(title: "삭제", style: .plain, target: self, action: #selector(tappedDeleteButton))
        
        navigationItem.rightBarButtonItems = [editButton, deleteButton]
    }
    
    func setBookToView() {
        guard let book = book else { return }
        
        movieTitleLabel.text = book.title
        infoLabel.text = book.author
        rateLabel.text = "₩\(makeIntToWonString(int: book.price))"
        
        bottomTextView.text = book.review
        
        let image = loadImageToDocument(fileName: "book_\(book._id).jpg")
        posterImageView.image = image
        posterBackgroundImageView.image = image
    }

    func setMovieToView(movie: Movie) {
        
        let poster = UIImage(named: movie.title)
        posterBackgroundImageView.image = poster
        posterImageView.image = poster
        
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
    
    func makeIntToWonString(int: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(for: int)!
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
