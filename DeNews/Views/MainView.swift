//
//  MainView.swift
//  DeNews
//
//  Created by Deniz Dilbilir on 23/09/2024.
//

import SwiftUI

struct MainView: View {
    @State private var isSearching = false
    @State private var searchText = ""
    @State private var selectedCategory = "General"
    @Bindable var viewModel: MainViewModel
    var savedViewModel: SavedArticlesViewModel

    let categories = ["General", "Entertainment", "Health", "Science", "Sports", "Technology"]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    categoryScrollView
                    
                    if viewModel.isRefreshing {
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: 250)
                            .padding(.top, 20)
                    } else {
                        if let article = viewModel.article {
                            ReusableView(
                                article: article,
                                imageUrl: article.urlToImage,
                                additionalArticles: Array(viewModel.categoryArticles[selectedCategory]?.dropFirst() ?? []),
                                savedViewModel: savedViewModel)
                            .padding(.leading, 20)
                        } else {
                            Text("No headline available")
                                .font(.headline)
                                .padding()
                        }
                    }
                    Spacer()
                }
                .navigationTitle("DeNews")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    searchToolbarItem
                }
                .onChange(of: selectedCategory, initial: true) { oldCategory, newCategory in
                    viewModel.fetchHeadline(for: newCategory)
                }
            }
        }
    }
    
    private var categoryScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(categories, id: \.self) { category in
                    VStack {
                        Text(category)
                            .foregroundStyle(.secondary)
                            .frame(height: 30)
                         
                        if selectedCategory == category {
                            Rectangle()
                                .fill(Color.red)
                                .frame(height: 2)
                        } else {
                            Rectangle()
                                .fill(Color.clear)
                                .frame(height: 2)
                        }
                    }
                    .onTapGesture {
                        selectedCategory = category
                    }
                    .contentShape(Rectangle())
                }
            }
            .padding(.top, 10)
            .padding(.leading, 40)
            .padding(.trailing, 40)
            .padding(.bottom, 15)
            .padding(.horizontal)
        }
    }

    private var searchToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button(action: {
                isSearching = true
            }) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.gray)
            }
            .sheet(isPresented: $isSearching) {
                SearchView()
            }
        }
    }
}

#Preview {
    MainView(viewModel: MainViewModel(), savedViewModel: SavedArticlesViewModel())
}
