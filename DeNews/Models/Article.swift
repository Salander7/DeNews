//  Article.swift
//  DeNews
//
//  Created by Deniz Dilbilir on 24/09/2024.
//

import Foundation

// MARK: - NewsResponse
struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable, Equatable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?

}

// MARK: - Source
struct Source: Codable, Equatable {
    let id: String?
    let name: String
}
