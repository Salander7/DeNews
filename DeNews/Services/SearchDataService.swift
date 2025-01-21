//
//  SearchDataService.swift
//  DeNews
//
//  Created by Deniz Dilbilir on 24/09/2024.
//

import Foundation

class SearchDataService {
    private lazy var apiKey: String = loadAPIKey()
    private let baseURL = "https://newsapi.org/v2/everything"
    
    private func loadAPIKey() -> String {
        if let path = Bundle.main.path(forResource: "APIKey", ofType: "plist"),
           let plist = NSDictionary(contentsOfFile: path) as? [String: Any],
           let key = plist["APIKey"] as? String {
            return key
        }
        return ""
    }
    
    func searchArticles(query: String) async throws -> [Article] {
        let formattedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "\(baseURL)?q=\(formattedQuery)&sortBy=popularity&apiKey=\(apiKey)&language=en"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
        return newsResponse.articles
    }
}

    
