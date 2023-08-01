//
//  Extension+UIView.swift
//  BookWorm
//
//  Created by Eunbee Kang on 2023/08/01.
//

import UIKit

extension UIView {
    func configShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 10
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.masksToBounds = false
    }
}
