//
//  SearchViewController.swift
//  BookWorm
//
//  Created by Eunbee Kang on 2023/07/31.
//

import UIKit
import Alamofire
import SwiftyJSON

class SearchViewController: UIViewController {
    
    @IBOutlet var resultCollectionView: UICollectionView!
    
    let searchBar = UISearchBar()
    
    var bookList: [Book] = []
    var colors: [UIColor] = []
    var page = 1
    var isEnd = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resultCollectionView.delegate = self
        resultCollectionView.dataSource = self
        resultCollectionView.prefetchDataSource = self
        
        searchBar.delegate = self
        
        let resultCollectionViewCellNib = UINib(nibName: BookCollectionViewCell.identifier, bundle: nil)
        resultCollectionView.register(resultCollectionViewCellNib, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
        
        configUI()
        configSearchBar()
        configCollectionViewLayout()
    }
    
    // MARK: - Helper
    
    func callRequest(query: String, page: Int) {
        guard let searchText = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let url = "https://dapi.kakao.com/v3/search/book?query=\(searchText)&size=14&page=\(page)"
        let header: HTTPHeaders = ["Authorization": "KakaoAK \(APIKey.kakao)"]
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let statusCode = response.response?.statusCode ?? 500
                
                if statusCode == 200 {
                    self.isEnd = json["meta"]["is_end"].boolValue
                    
                    self.makeJsonToBookList(json: json)
//                    self.makeRandomCellColors()
                    self.resultCollectionView.reloadData()
                    
                } else {
                    print("문제 발생")
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func makeJsonToBookList(json: JSON) {
        let documents = json["documents"].arrayValue
        
        for item in documents {
            let title = item["title"].stringValue
            let authors = item["authors"].arrayValue
            let thumbnail = item["thumbnail"].stringValue
            let date = item["datetime"].stringValue
            let contents = item["contents"].stringValue
            let price = item["price"].intValue

            var author = ""
            if authors.count > 0 {
                author = authors[0].stringValue
            }
            
            let book = Book(title: title, author: author, thumbnail: thumbnail, date: date, contents: contents, price: price)
            
            bookList.append(book)
            
            let red = CGFloat.random(in: 0...1)
            let green = CGFloat.random(in: 0...1)
            let blue = CGFloat.random(in: 0...1)
            let color = UIColor(red: red, green: green, blue: blue, alpha: 1)
            colors.append(color)
            
        }
    }
    
    func makeRandomCellColors() {
        let number = bookList.count
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
    
    // MARK: - Action
    
    @objc func dismissSearchViewController() {
        dismiss(animated: true)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as? BookCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configCell(item: bookList[indexPath.item])
        cell.cellBackgroundView.backgroundColor = colors[indexPath.item]
        
        return cell
    }
}

// MARK: - UICollectionViewDataSourcePrefetching

extension SearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard let query = searchBar.text else { return }
        
        for indexPath in indexPaths {
            if bookList.count - 1 == indexPath.item && page < 50 && !isEnd {
                page += 1
                callRequest(query: query, page: page)
            }
        }
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        bookList.removeAll()
        colors.removeAll()
        
        guard let query = searchBar.text else { return }
        callRequest(query: query, page: page)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        bookList.removeAll()
        resultCollectionView.reloadData()
    }
}

// MARK: - UI & layout

extension SearchViewController {
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
        
        let xmark = UIImage(systemName: "xmark")
        let xmarkButton = UIBarButtonItem(image: xmark, style: .plain, target: self, action: #selector(dismissSearchViewController))
        navigationItem.leftBarButtonItem = xmarkButton
        
    }
    
    func configSearchBar() {
        searchBar.placeholder = "검색어를 입력하세요."
        searchBar.showsCancelButton = true
        
        navigationItem.titleView = searchBar
    }
}
