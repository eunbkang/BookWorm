//
//  RealmManager.swift
//  BookWorm
//
//  Created by Eunbee Kang on 2023/09/04.
//

import Foundation
import RealmSwift

class RealmManager {
    
    private let realm: Realm
    
    static let shared = RealmManager()
    
    private init() {
        realm = try! Realm()
    }
    
    func setNewBook(book: BookTable) {
        try! realm.write {
            realm.add(book)
        }
    }
    
    func updateBook(book: BookTable?) {
        // 에러
        // Attempting to modify object outside of a write transaction - call beginWriteTransaction on an RLMRealm instance first.
    }
    
    func deleteBook(book: BookTable) {
        try! realm.write {
            realm.delete(book)
        }
    }
    
    func fetchBooks() -> Results<BookTable> {
        return realm.objects(BookTable.self)
    }
    
    func getFileUrl() {
        print(realm.configuration.fileURL)
    }
}
