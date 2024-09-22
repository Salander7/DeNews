//
//  SearchView.swift
//  DeNews
//
//  Created by Deniz Dilbilir on 23/09/2024.
//

import SwiftUI

struct SearchView: View {
    @State var viewModel = SearchViewModel()
    @Environment(\.dismiss) private var dismiss
    @State private var searchInitiated = false
    @State private var selectedArticleUrl: URL?

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    SearchBarView(search: $viewModel.search)
                    Button("Cancel") {
                        UIApplication.shared.dismissKeyboard()
                        dismiss()
                        searchInitiated = false
                    }
                    .foregroundStyle(.secondary)
                    .padding(.trailing, 8)
                }
                .padding(.horizontal)
                .padding(.top, 8)

                ZStack {
                    if viewModel.isLoading {
                        ProgressView()
                    } else if searchInitiated && viewModel.searchResults.isEmpty {
                        Text("No results found 🫤")
                            .font(.title2)
                            .foregroundStyle(.secondary)
                    } else {
                        List(viewModel.searchResults, id: \.url) { article in
                            HStack(alignment: .top) {
                                if let imageUrl = article.urlToImage, let url = URL(string: imageUrl) {
                                    AsyncImage(url: url) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 60, height: 60)
                                            .cornerRadius(8)
                                    } placeholder: {
                                        Color.gray
                                            .frame(width: 60, height: 60)
                                            .cornerRadius(8)
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
                        .listStyle(PlainListStyle())
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(item: $selectedArticleUrl) { url in
                SafariView(url: url)
            }
            .onSubmit {
                searchInitiated = true
                UIApplication.shared.dismissKeyboard()
                viewModel.performSearch()
            }
            .onChange(of: viewModel.search) {
                if viewModel.search.isEmpty {
                    searchInitiated = false
                    viewModel.clearSearch()
                }
            }
        }
    }
}

#Preview {
    SearchView()
}

