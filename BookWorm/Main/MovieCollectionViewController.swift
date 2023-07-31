//
//  MovieCollectionViewController.swift
//  BookWorm
//
//  Created by Eunbee Kang on 2023/07/31.
//

import UIKit

private let reuseIdentifier = "Cell"

class MovieCollectionViewController: UICollectionViewController {

    var movieList = MovieData().movie
    var colors: [UIColor] = [.systemRed, .systemOrange, .systemYellow, .systemGreen, .systemBlue, .systemIndigo, .systemPurple, .systemPink, .systemTeal, .systemBrown, .systemGray]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let movieCollectionViewCellNib = UINib(nibName: MovieCollectionViewCell.identifier, bundle: nil)
        collectionView.register(movieCollectionViewCellNib, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        
        configUI()
    }

    @IBAction func tappedSearchButton(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else {
            return
        }
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true)
    }
    
    func configUI() {
        title = "고래밥님의 책장"
        
        configCollectionViewLayout()
    }
    
    func configCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        
        let inset: CGFloat = 16
        let spacing: CGFloat = 8
        let width = UIScreen.main.bounds.width - spacing - (inset * 2)
        
        layout.itemSize = CGSize(width: width/2, height: width/2)
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        collectionView.collectionViewLayout = layout
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        let item = movieList[indexPath.item]
        
        let bgColor = colors.shuffled()[0]
        cell.cellBackgroundView.backgroundColor = bgColor
        colors.removeAll(where: { $0 == bgColor })
        
        cell.movieTitleLabel.text = item.title
        cell.posterImageView.image = UIImage(named: item.title)
        cell.rateLabel.text = String(item.rate)
        
        cell.configCell()
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController")
        
        vc.title = movieList[indexPath.item].title
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
