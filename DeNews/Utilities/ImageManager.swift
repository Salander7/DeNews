//
//  ImageManager.swift
//  DeNews
//
//  Created by Deniz Dilbilir on 24/09/2024.
//

import Foundation
import SwiftUI

class ImageManager {
    
    static let instance = ImageManager()
    private init() {}
    
    private var imageCache: NSCache<NSString, UIImage> = NSCache()
    private let queue = DispatchQueue(label: "com.DeNews.ImageCacheQueue")

    func cacheImage(image: UIImage, imageName: String) {
        queue.async {
            self.imageCache.setObject(image, forKey: NSString(string: imageName))
        }
    }
    
    func fetchImageFromCache(imageName: String) -> UIImage? {
        return queue.sync {
            return imageCache.object(forKey: NSString(string: imageName))
        }
    }
    
    func clearCacheForImage(imageName: String) {
        queue.async {
            self.imageCache.removeObject(forKey: NSString(string: imageName))
            print("Cleared cache for image: \(imageName)")
        }
    }
    
    func clearAllCache() {
        queue.async {
            self.imageCache.removeAllObjects()
            print("Cleared all cached images.")
        }
    }
}

