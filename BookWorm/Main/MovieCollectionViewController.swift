//
//  MovieCollectionViewController.swift
//  BookWorm
//
//  Created by Eunbee Kang on 2023/07/31.
//

import UIKit

class MovieCollectionViewController: UICollectionViewController {

    var movieList = MovieData() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var colors: [UIColor] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let movieCollectionViewCellNib = UINib(nibName: MovieCollectionViewCell.identifier, bundle: nil)
        collectionView.register(movieCollectionViewCellNib, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        
        configUI()
        makeRandomCellColors()
    }

    @IBAction func tappedSearchButton(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else {
            return
        }
        vc.movieList = movieList.movie
        vc.colors = colors
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true)
    }
    
    @objc func tappedLikeButton(_ sender: UIButton) {
        movieList.movie[sender.tag].isLiked.toggle()
    }
    
    func makeRandomCellColors() {
        let number = movieList.movie.count
        var randomColors: [UIColor] = []
        
        for _ in 0...number {
            let red = CGFloat.random(in: 0...1)
            let green = CGFloat.random(in: 0...1)
            let blue = CGFloat.random(in: 0...1)
            let color = UIColor(red: red, green: green, blue: blue, alpha: 1)
            randomColors.append(color)
        }
        
        colors = randomColors
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
}

extension MovieCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.movie.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        let item = movieList.movie[indexPath.item]
        
        cell.cellBackgroundView.backgroundColor = colors[indexPath.item]
        cell.configCell(item: item)
        
        cell.likeButton.tag = indexPath.item
        cell.likeButton.addTarget(self, action: #selector(tappedLikeButton), for: .touchUpInside)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        
        vc.movie = movieList.movie[indexPath.item]
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
