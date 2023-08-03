//
//  SearchViewController.swift
//  BookWorm
//
//  Created by Eunbee Kang on 2023/07/31.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet var resultCollectionView: UICollectionView!
    
    let searchBar = UISearchBar()
    
    var movieList = MovieData().movie
    var resultList: [Movie] = []
    
    var colors: [UIColor]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resultCollectionView.delegate = self
        resultCollectionView.dataSource = self
        
        searchBar.delegate = self
        
        let resultCollectionViewCellNib = UINib(nibName: MovieCollectionViewCell.identifier, bundle: nil)
        resultCollectionView.register(resultCollectionViewCellNib, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        
        configUI()
        configSearchBar()
        configCollectionViewLayout()
    }
    
    func configSearchBar() {
        searchBar.placeholder = "검색어를 입력하세요."
        searchBar.showsCancelButton = true
        
        navigationItem.titleView = searchBar
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
        
        resultCollectionView.collectionViewLayout = layout
    }
    
    func configUI() {
        title = "검색 화면"
        
//        let xmark = UIImage(systemName: "xmark")
//        let xmarkButton = UIBarButtonItem(image: xmark, style: .plain, target: self, action: #selector(dismissSearchViewController))
//        navigationItem.leftBarButtonItem = xmarkButton
        
    }
    
    @objc func dismissSearchViewController() {
        dismiss(animated: true)
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configCell(item: resultList[indexPath.item])
        
        guard let index = movieList.firstIndex(where: { $0.title == resultList[indexPath.item].title }) else { return UICollectionViewCell() }
        cell.cellBackgroundView.backgroundColor = colors?[index]
        
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        resultList = movieList.filter( { $0.title.contains(searchBar.text!) } )
        resultCollectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        resultList.removeAll()
        dismiss(animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        resultList = movieList.filter( { $0.title.contains(searchBar.text!) } )
        resultCollectionView.reloadData()
    }
}
