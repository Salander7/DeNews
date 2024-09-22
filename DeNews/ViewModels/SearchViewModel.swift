//
//  SearchViewModel.swift
//  DeNews
//
//  Created by Deniz Dilbilir on 25/09/2024.
//

import Foundation

@Observable class SearchViewModel {
    var searchResults: [Article] = []
    var search: String = "" {
        didSet {
            if search.isEmpty {
                clearSearch()
            }
        }
    }
    var isLoading: Bool = false
    private let searchService = SearchDataService()
    
    func performSearch() {
        guard !search.isEmpty else { return }
        isLoading = true
        
        Task {
            do {
                let articles = try await searchService.searchArticles(query: search)
                
                let validArticles = articles.filter { article in
                    !(article.title.isEmpty || article.urlToImage == nil || article.description == nil)
                }
                
                let sortedArticles = sortArticlesByRelevanceAndDate(articles: validArticles, query: search)
                self.searchResults = sortedArticles
                self.isLoading = false
            } catch {
                print("Search error: \(error.localizedDescription)")
                isLoading = false
            }
        }
    }
    
    func clearSearch() {
        searchResults = []
    }
    
    private func sortArticlesByRelevanceAndDate(articles: [Article], query: String) -> [Article] {
        return articles.sorted { (article1, article2) -> Bool in
         
            let relevance1 = relevanceScore(for: article1, query: query)
            let relevance2 = relevanceScore(for: article2, query: query)
            
            if relevance1 != relevance2 {
                return relevance1 > relevance2
            }
            return article1.publishedAt > article2.publishedAt
        }
    }
    
    private func relevanceScore(for article: Article, query: String) -> Int {
        
        let titleOccurrences = article.title.lowercased().components(separatedBy: query.lowercased()).count - 1
        let descriptionOccurrences = article.description?.lowercased().components(separatedBy: query.lowercased()).count ?? 0 - 1

        return titleOccurrences * 3 + descriptionOccurrences * 2
    }
}

