//
//  MainViewModel.swift
//  DeNews
//
//  Created by Deniz Dilbilir on 25/09/2024.
//

import Foundation

@MainActor
@Observable class MainViewModel {
    var categoryArticles: [String: [Article]] = [:]
    var displayedArticles: Set<String> = []
    var article: Article? = nil
    var isRefreshing: Bool = false
    
    private let articleDataService = ArticleDataService()
    
    func fetchHeadline(for category: String) {
     
        if let cachedArticles = categoryArticles[category], !cachedArticles.isEmpty {
    
            self.article = cachedArticles.first(where: { !$0.title.isEmpty && $0.description != nil && $0.urlToImage != nil })
            return
        }

        Task { @MainActor in
            isRefreshing = true
            guard let fetchedArticles = await articleDataService.fetchArticles(for: category.lowercased()) else {
                    self.article = nil
                    self.isRefreshing = false
                    return
            }

            let uniqueArticles = fetchedArticles.filter {
                !self.displayedArticles.contains($0.url) && !$0.title.isEmpty && $0.description != nil && $0.urlToImage != nil
            }

                self.categoryArticles[category] = uniqueArticles
                self.article = uniqueArticles.first
                uniqueArticles.forEach { self.displayedArticles.insert($0.url) }
                self.isRefreshing = false
        }
    }
}
