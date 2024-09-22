//
//  ReusableView.swift
//  DeNews
//
//  Created by Deniz Dilbilir on 23/09/2024.
//

import SwiftUI

struct ReusableView: View {
    var article: Article
    var imageUrl: String?
    var additionalArticles: [Article]
    @State private var selectedArticleUrl: URL?
    var savedViewModel: SavedArticlesViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack(alignment: .top) {
                if let url = URL(string: imageUrl ?? "") {
                    VStack(spacing: 0) {
                        Button(action: {
                            selectedArticleUrl = URL(string: article.url)
                        }) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 460, height: 250)
                                    .clipped()
                                    .allowsHitTesting(false)
                            } placeholder: {
                                Color.clear
                                    .frame(width: 460, height: 250)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        HStack {
                            if let date = article.publishedAt.formattedDate() {
                                Text(date)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .padding(.leading, 40)
                                Spacer()
                                HStack(spacing: 15) {
                                    Button(action: {
                                        print("Share action for article: \(article.title)")
                                    }) {
                                        Image(systemName: "square.and.arrow.up")
                                            .foregroundStyle(.secondary)
                                    }
                                    
                                    Button(action: {
                                        if savedViewModel.isArticleSaved(article) {
                                            savedViewModel.removeArticle(article)
                                        } else {
                                            savedViewModel.addArticle(article)
                                        }
                                    }) {
                                        Image(systemName: savedViewModel.isArticleSaved(article) ? "bookmark.fill" : "bookmark")
                                            .foregroundStyle(.secondary)
                                    }
                                }
                                .padding(.trailing, 60)
                            }
                        }
                        .padding(.top, 20)
                    }
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Button(action: {
                        selectedArticleUrl = URL(string: article.url)
                    }) {
                        VStack(alignment: .leading, spacing: 20) {
                            Text(article.title)
                                .font(.system(size: 22, weight: .semibold, design: .serif))
                                .padding(.leading, 40)
                                .padding(.trailing, 50)
                            Text(article.description ?? "No description available")
                                .font(.system(size: 17, weight: .light, design: .serif))
                                .padding(.leading, 40)
                                .padding(.trailing, 50)
                            
                            Rectangle()
                                .fill(Color.yellow)
                                .frame(height: 2)
                                .padding(.leading, 40)
                                .padding(.trailing, 60)
                                .padding(.bottom, 10)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.top, 310)
            }
            
            AdditionalArticlesView(
                additionalArticles: additionalArticles,
                selectedArticleUrl: $selectedArticleUrl,
                savedViewModel: savedViewModel)
        }
        .frame(maxWidth: .infinity)
        .sheet(item: $selectedArticleUrl) { url in
            SafariView(url: url)
        }
    }
}

#Preview {
    ReusableView(
        article: Article.example,
        imageUrl: Article.example.urlToImage,
        additionalArticles: [Article.example, Article.example, Article.example, Article.example, Article.example],
        savedViewModel: SavedArticlesViewModel()
    )
}

