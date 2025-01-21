//
//  SavedArticlesViewModel.swift
//  DeNews
//
//  Created by Deniz Dilbilir on 12/12/2024.
//

import Foundation
import SwiftData

@Observable
final class SavedArticlesViewModel {
    private var modelContext: ModelContext
    var savedArticles: [Article] = []
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        loadSavedArticles()
    }
    
    func loadSavedArticles() {
        let descriptor = FetchDescriptor<SavedArticle>()
        if let results = try? modelContext.fetch(descriptor) {
            self.savedArticles = results.map {
                Article(
                    source: Source(id: nil, name: ""),
                    author: nil,
                    title: $0.title,
                    description: $0.descriptionText,
                    url: $0.url,
                    urlToImage: $0.urlToImage,
                    publishedAt: $0.publishedAt,
                    content: nil
                )
            }
        }
    }
    
    func addArticle(_ article: Article) {
        guard !isArticleSaved(article) else { return }
        let saved = SavedArticle(
            url: article.url,
            title: article.title,
            descriptionText: article.description,
            urlToImage: article.urlToImage,
            publishedAt: article.publishedAt
        )
        modelContext.insert(saved)
        try? modelContext.save()
        loadSavedArticles()
    }
    
    func removeArticle(_ article: Article) {
        let descriptor = FetchDescriptor<SavedArticle>(predicate: #Predicate { $0.url == article.url })
        if let results = try? modelContext.fetch(descriptor), let item = results.first {
            modelContext.delete(item)
            try? modelContext.save()
            loadSavedArticles()
        }
    }
    
    func isArticleSaved(_ article: Article) -> Bool {
        return savedArticles.contains { $0.url == article.url }
    }
}
