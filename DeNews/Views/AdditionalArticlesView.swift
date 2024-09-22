//
//  AdditionalArticlesView.swift
//  DeNews
//
//  Created by Deniz Dilbilir on 26/11/2024.
//

import SwiftUI

struct AdditionalArticlesView: View {
    var additionalArticles: [Article]
    @Binding var selectedArticleUrl: URL?
    var savedViewModel: SavedArticlesViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("More")
                .padding(.leading, 40)
                .bold()
                .font(.system(size: 16))
            
            ForEach(additionalArticles.prefix(4), id: \.url) { additionalArticle in
                Button(action: {
                    selectedArticleUrl = URL(string: additionalArticle.url)
                }) {
                    HStack(alignment: .top) {
                        if let imageUrl = additionalArticle.urlToImage, let url = URL(string: imageUrl) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .padding(.leading, 20)
                            } placeholder: {
                                Color.gray
                                    .frame(width: 60, height: 60)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(additionalArticle.title)
                                .font(.system(size: 18, weight: .semibold, design: .serif))
                        }
                        .padding(.leading, 8)
                        .padding(.trailing, 10)
                        
                        Spacer()
                        
                        Button(action: {
                            if savedViewModel.isArticleSaved(additionalArticle) {
                                savedViewModel.removeArticle(additionalArticle)
                            } else {
                                savedViewModel.addArticle(additionalArticle)
                            }
                        }) {
                            Image(systemName: savedViewModel.isArticleSaved(additionalArticle) ? "bookmark.fill" : "bookmark")
                                .foregroundStyle(.secondary)
                                .padding(.trailing, 60)
                        }
                    }
                    .padding(.vertical, 8)
                    .padding(.leading, 20)
                }
                .buttonStyle(.plain)
            }
            Rectangle()
                .fill(Color.yellow)
                .frame(height: 2)
                .padding(.leading, 40)
                .padding(.trailing, 60)
                .padding(.bottom, 10)
            
            if additionalArticles.count > 4 {
                let fiftArticle = additionalArticles[4]
                Button(action: {
                    selectedArticleUrl = URL(string: fiftArticle.url)
                }) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(fiftArticle.title)
                            .font(.system(size: 22, weight: .semibold, design: .serif))
                            .padding(.leading, 40)
                            .multilineTextAlignment(.leading)
                            .padding(.trailing, 50)
                            .padding(.bottom, 10)
                        
                        HStack(alignment: .top) {
                            if let imageUrl = fiftArticle.urlToImage, let url = URL(string: imageUrl) {
                                AsyncImage(url: url) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 150)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .padding(.leading, 20)
                                } placeholder: {
                                    Color.gray
                                        .frame(width: 100, height: 150)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .padding(.leading, 20)
                                }
                            }
                            
                            VStack(alignment: .leading, spacing: 10) {
                                Text(fiftArticle.description ?? "No description available.")
                                    .font(.system(size: 17, weight: .light, design: .serif))
                                    .lineLimit(7)
                                    .truncationMode(.tail)
                                    .multilineTextAlignment(.leading)
                                    .padding(.leading, 10)
                                
                                Spacer()
                                
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        if savedViewModel.isArticleSaved(fiftArticle) {
                                            savedViewModel.removeArticle(fiftArticle)
                                        } else {
                                            savedViewModel.addArticle(fiftArticle)
                                        }
                                    }) {
                                        Image(systemName: savedViewModel.isArticleSaved(fiftArticle) ? "bookmark.fill" : "bookmark")
                                            .foregroundStyle(.secondary)
                                            .padding(.trailing, 10)
                                    }
                                }
                            }
                            .padding(.leading, 6) 
                            .padding(.trailing, 50)
                        }
                        .padding(.leading, 20)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}

