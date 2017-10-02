//
//  Extensions.swift
//  GameOfChats
//
//  Created by Fábio Salata on 02/10/17.
//  Copyright © 2017 Fábio Salata. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadImageUsingCacheWithUrlString(urlString: String) {
        self.image = nil
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard error == nil else {
                    print(error!)
                    return
                }
                
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                    
                    DispatchQueue.main.async {
                        self.image = downloadedImage
                    }
                }
            }.resume()
        }
    }
}
