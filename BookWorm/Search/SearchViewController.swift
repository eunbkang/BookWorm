//
//  SearchViewController.swift
//  BookWorm
//
//  Created by Eunbee Kang on 2023/07/31.
//

import UIKit

class SearchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    func configUI() {
        title = "검색 화면"
        
        let xmark = UIImage(systemName: "xmark")
        let xmarkButton = UIBarButtonItem(image: xmark, style: .plain, target: self, action: #selector(dismissSearchViewController))
        navigationItem.leftBarButtonItem = xmarkButton
        
    }
    
    @objc func dismissSearchViewController() {
        dismiss(animated: true)
    }

}
