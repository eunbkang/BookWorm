//
//  AppDelegate.swift
//  BookWorm
//
//  Created by Eunbee Kang on 2023/07/31.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UINavigationBar.appearance().tintColor = .systemPink
        UITabBar.appearance().tintColor = .systemPink
        
        let config = Realm.Configuration(schemaVersion: 4) { migration, oldSchemaVersion in
            if oldSchemaVersion < 1 { } // isLiked 컬럼 추가
            
            if oldSchemaVersion < 2 { // thumbnail -> thumbnailUrl 컬럼명 변경
                migration.renameProperty(onType: BookTable.className(), from: "thumbnail", to: "thumbnailUrl")
            }
            
            if oldSchemaVersion < 3 { } // isLiked 컬럼 삭제
            
            if oldSchemaVersion < 4 { // titleAndAuhor 컬럼 추가, title/author 포함
                migration.enumerateObjects(ofType: BookTable.className()) { oldObject, newObject in
                    guard let new = newObject else { return }
                    guard let old = oldObject else { return }
                    
                    new["titleAndAuthor"] = "\(old["title"]) written by \(new["author"])"
                }
            }
        }
        
        Realm.Configuration.defaultConfiguration = config
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

