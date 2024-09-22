//
//  SavedView.swift
//  DeNews
//
//  Created by Deniz Dilbilir on 14/10/2024.
//

import SwiftUI

struct SavedView: View {
    var savedViewModel: SavedArticlesViewModel
    @State private var selectedArticleUrl: URL?

    var body: some View {
        NavigationStack {
            VStack {
                if savedViewModel.savedArticles.isEmpty {
                    Text("No saved articles yet.")
                        .font(.title2)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                } else {
                    List {
                        ForEach(savedViewModel.savedArticles, id: \.url) { article in
                            HStack(alignment: .top) {
                                if let imageUrl = article.urlToImage, let url = URL(string: imageUrl) {
                                    AsyncImage(url: url) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 60, height: 60)
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                        
                                    } placeholder: {
                                        Color.gray
                                            .frame(width: 60, height: 60)
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                    }
                                }
                                VStack(alignment: .leading, spacing: 4) {
                                    Button(action: {
                                        selectedArticleUrl = URL(string: article.url)
                                    }) {
                                        Text(article.title)
                                            .font(.headline)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    Text(article.description ?? "No description")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                    if let date = article.publishedAt.formattedDate() {
                                        Text(date)
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                                .padding(.leading, 8)
                            }
                            .padding(.vertical, 8)
                        }
                        .onDelete { indexSet in
                            indexSet.forEach { index in
                                let article = savedViewModel.savedArticles[index]
                                savedViewModel.removeArticle(article)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Saved Articles")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(item: $selectedArticleUrl) { url in
                SafariView(url: url)
            }
        }
    }
}

#Preview {
    SavedView(savedViewModel: SavedArticlesViewModel())
}

