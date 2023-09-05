//
//  FileManager.swift
//  BookWorm
//
//  Created by Eunbee Kang on 2023/09/05.
//

import UIKit

extension UIViewController {
    
    func saveImageToDocument(fileName: String, imageUrl: String) {
        
        convertUrlToImage(imageUrl: imageUrl) { image in
            guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
            
            let fileURL = documentDirectory.appendingPathComponent(fileName)
            
            guard let data = image.jpegData(compressionQuality: 0.5) else { return }
            
            do {
                try data.write(to: fileURL)
            } catch let error {
                print("file save error", error)
            }
        }
    }
    
    func loadImageToDocument(fileName: String) -> UIImage {
        let placeholderImage = UIImage(systemName: "sparkles")!
        
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return placeholderImage
        }
        
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path) ?? placeholderImage
        } else {
            return placeholderImage
        }
    }
    
    func removeImageFromDocument(fileName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch {
            print(error)
        }
    }
    
    func convertUrlToImage(imageUrl: String, completion: @escaping (UIImage) -> ()) {
        
        DispatchQueue.global().async {
            if let url = URL(string: imageUrl) {
                do {
                    let data = try Data(contentsOf: url)
                    if let image = UIImage(data: data) {
                        completion(image)
                    }
                    
                } catch {
                    print("error making UIImage with data")
                }
            }
        }
    }
}
