//
//  TabBarView.swift
//  DeNews
//
//  Created by Deniz Dilbilir on 14/10/2024.
//

import SwiftUI
import SwiftData

enum TabItem: Hashable {
    case home
    case saved
}

struct TabBarView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var savedViewModel: SavedArticlesViewModel?
    @State private var selectedTab: TabItem = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            if let savedViewModel = savedViewModel {
                MainView(viewModel: MainViewModel(), savedViewModel: savedViewModel)
                    .tag(TabItem.home)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }

                SavedView(savedViewModel: savedViewModel)
                    .tag(TabItem.saved)
                    .tabItem {
                        Label("Saved", systemImage: "bookmark")
                    }
            } else {
                Text("Loading...")
                    .tag(TabItem.home)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }

                Text("Loading...")
                    .tag(TabItem.saved)
                    .tabItem {
                        Label("Saved", systemImage: "bookmark")
                    }
            }
        }
        .tint(.primary)
        .onAppear {
            if savedViewModel == nil {
                savedViewModel = SavedArticlesViewModel(modelContext: modelContext)
            }
        }
    }
    
}

#Preview {
    TabBarView()
}

