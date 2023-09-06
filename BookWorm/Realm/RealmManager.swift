//
//  RealmManager.swift
//  BookWorm
//
//  Created by Eunbee Kang on 2023/09/04.
//

import Foundation
import RealmSwift

final class BookTableRepository {
    
    private let realm = try! Realm()
    
    func createItem(_ item: BookTable) {
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print(error)
        }
    }
    
    func updateBook(id: ObjectId, review: String) {
        do {
            try realm.write {
                realm.create(
                    BookTable.self,
                    value: ["_id": id, "review": review],
                    update: .modified
                )
            }
        } catch {
            print(error)
        }
    }
    
    func delete(_ item: BookTable) {
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print(error)
        }
    }
    
    func fetch() -> Results<BookTable> {
        return realm.objects(BookTable.self)
    }
    
    func getFileUrl() {
        print("FileUrl: ", realm.configuration.fileURL!)
    }
    
    func checkSchemaVersion() {
        do {
            let version = try schemaVersionAtURL(realm.configuration.fileURL!)
            print("Schema Version: \(version)")
        } catch {
            print(error)
        }
    }
}
