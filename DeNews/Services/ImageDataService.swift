//
//  ImageDataService.swift
//  DeNews
//
//  Created by Deniz Dilbilir on 24/09/2024.
//

import Foundation
import SwiftUI

@Observable class ImageDataService {
    
    var image: UIImage? = nil
    var isLoading: Bool = false
    var errorMessage: String?

    private let article: Article
    private let fileManager = ImageManager.instance
    private var lastFetchDate: Date?
    private let cacheDuration: TimeInterval

    init(article: Article, cacheDuration: TimeInterval = 86400) {
        self.article = article
        self.cacheDuration = cacheDuration
        fetchArticleImage()
    }
    
    private func fetchArticleImage() {
        guard let urlString = article.urlToImage, let url = URL(string: urlString) else {
            errorMessage = "Invalid image URL."
            print(errorMessage!)
            return
        }

        let imageName = url.lastPathComponent
        
        
        if let lastFetchDate = lastFetchDate, Date().timeIntervalSince(lastFetchDate) > cacheDuration {
            fileManager.clearCacheForImage(imageName: imageName)
        }

       
        if let cachedImage = fileManager.fetchImageFromCache(imageName: imageName) {
            image = cachedImage
            print("Image loaded from cache.")
            return
        }

        isLoading = true
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let downloadedImage = UIImage(data: data) {
                    image = downloadedImage
                    fileManager.cacheImage(image: downloadedImage, imageName: imageName)
                    lastFetchDate = Date()
                    print("Image downloaded and cached.")
                } else {
                    errorMessage = "Failed to convert data to image."
                    print(errorMessage!)
                }
            } catch {
                errorMessage = "Failed to fetch image: \(error.localizedDescription)"
                print(errorMessage!)
            }
            isLoading = false
        }
    }
}

