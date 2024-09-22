//
//  ArticleDataService.swift
//  DeNews
//
//  Created by Deniz Dilbilir on 24/09/2024.
//

import Foundation

@Observable class ArticleDataService {
    var articleList: [Article] = []
    private var apiKey: String {
        return loadAPIKey()
    }
    private let baseURL = "https://newsapi.org/v2/top-headlines?country=us&pageSize=20&category="
    
    init() {}
    
    private func loadAPIKey() -> String {
        if let path = Bundle.main.path(forResource: "APIKey", ofType: "plist"),
           let plist = NSDictionary(contentsOfFile: path) as? [String: Any],
           let key = plist["APIKey"] as? String {
            return key
        }
        return ""
    }

    func fetchArticles(for category: String) async -> [Article]? {
        guard let url = URL(string: baseURL + category + "&apiKey=" + apiKey) else {
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(NewsResponse.self, from: data)
            return response.articles
        } catch {
            print("Failed to fetch articles for category \(category): \(error)")
            return nil
        }
    }
}

