//
// Example.swift
// DeNews
//
// Created by Deniz Dilbilir on [date].

import Foundation

extension Article {
    static var example: Article {
        Article(
            source: Source(id: nil, name: "Example Source"),
            author: "John Doe",
            title: "Sample Title",
            description: "This is a sample description for the article.",
            url: "https://example.com/sample-article",
            urlToImage: "https://example.com/sample-image.jpg",
            publishedAt: "2024-10-29T12:00:00Z",
            content: "Sample content for the article."
        )
    }
}
