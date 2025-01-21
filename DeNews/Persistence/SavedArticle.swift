//
//  SavedArticle.swift
//  DeNews
//
//  Created by Deniz Dilbilir on 18/12/2024.
//

import SwiftData

@Model
final class SavedArticle {
    @Attribute(.unique) var url: String
    var title: String
    var descriptionText: String?
    var urlToImage: String?
    var publishedAt: String

    init(url: String, title: String, descriptionText: String?, urlToImage: String?, publishedAt: String) {
        self.url = url
        self.title = title
        self.descriptionText = descriptionText
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
    }
}
