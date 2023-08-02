//
//  BrowseViewController.swift
//  BookWorm
//
//  Created by Eunbee Kang on 2023/08/02.
//

import UIKit

class BrowseViewController: UIViewController {
    @IBOutlet var browseTableView: UITableView!
    @IBOutlet var browseCollectionView: UICollectionView!
    
    var movieList = MovieData().movie
    
    override func viewDidLoad() {
        super.viewDidLoad()

        browseCollectionView.delegate = self
        browseCollectionView.dataSource = self
        
        let browseCollectionViewCellNib = UINib(nibName: BrowseCollectionViewCell.identifier, bundle: nil)
        browseCollectionView.register(browseCollectionViewCellNib, forCellWithReuseIdentifier: BrowseCollectionViewCell.identifier)
        
        browseTableView.delegate = self
        browseTableView.dataSource = self
        
        let browseTableViewCellNib = UINib(nibName: BrowseTableViewCell.identifier, bundle: nil)
        browseTableView.register(browseTableViewCellNib, forCellReuseIdentifier: BrowseTableViewCell.identifier)
        
        browseTableView.rowHeight = 120
        
        configCollectionViewLayout()
    }
    
    func configCollectionViewLayout() {
        // cell estimated size - none으로 인터페이스 빌더에서 설정할 것
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let inset: CGFloat = 16
        let spacing: CGFloat = 8
        let width: CGFloat = 100

        layout.itemSize = CGSize(width: width, height: width * 4/3)
        layout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: inset, right: inset)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing

        browseCollectionView.collectionViewLayout = layout
    }
}

// MARK: - UICollectionView Delegate, DataSource

extension BrowseViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BrowseCollectionViewCell.identifier, for: indexPath) as? BrowseCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.posterImageView.image = UIImage(named: movieList[indexPath.item].title)
        cell.posterImageView.contentMode = .scaleAspectFill
        
        return cell
    }
}


// MARK: - UITableView Delegate, DataSource

extension BrowseViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BrowseTableViewCell.identifier) as? BrowseTableViewCell else {
            return UITableViewCell()
        }
        let row = movieList[indexPath.row]
        cell.configCellData(row: row)
        
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "요즘 인기 작품"
    }

}
