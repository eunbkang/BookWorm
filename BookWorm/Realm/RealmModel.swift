//
//  RealmModel.swift
//  BookWorm
//
//  Created by Eunbee Kang on 2023/09/04.
//

import Foundation
import RealmSwift

class BookTable: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String
    @Persisted var author: String
    @Persisted var price: Int
    @Persisted var thumbnailUrl: String
    @Persisted var review: String?
//    @Persisted var isLiked: Bool
    @Persisted var titleAndAuthor: String
    
    convenience init(title: String, author: String, price: Int, thumbnail: String, review: String?) {
        self.init()
        
        self.title = title
        self.author = author
        self.price = price
        self.thumbnailUrl = thumbnail
        self.review = review
//        self.isLiked = false
        self.titleAndAuthor = "\(title) written by \(author)"
    }
}
