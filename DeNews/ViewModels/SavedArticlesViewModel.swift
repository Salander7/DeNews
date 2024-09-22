//
//  SavedArticlesViewModel.swift
//  DeNews
//
//  Created by Deniz Dilbilir on 12/12/2024.
//

import Foundation

@Observable
final class SavedArticlesViewModel {
    var savedArticles: [Article] = []
    
    func addArticle(_ article: Article) {
       guard !isArticleSaved(article) else { return }
        savedArticles.append(article)
    }
    func removeArticle(_ article: Article) {
        savedArticles.removeAll() { $0.url == article.url }
    }
    func isArticleSaved(_ article: Article) -> Bool {
        savedArticles.contains { $0.url == article.url }
    }
}
