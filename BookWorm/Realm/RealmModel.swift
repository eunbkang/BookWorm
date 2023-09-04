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
    @Persisted var thumbnail: String
    
    convenience init(title: String, author: String, price: Int, thumbnail: String) {
        self.init()
        
        self.title = title
        self.author = author
        self.price = price
        self.thumbnail = thumbnail
    }
}
