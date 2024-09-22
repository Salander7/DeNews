//
//  TabBarView.swift
//  DeNews
//
//  Created by Deniz Dilbilir on 14/10/2024.
//

import SwiftUI

enum TabItem: Hashable {
    case home
    case saved
}

struct TabBarView: View {
    @State private var savedViewModel = SavedArticlesViewModel()
    @State private var selectedTab: TabItem = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Home", systemImage: "house", value: TabItem.home) {
                MainView(viewModel: MainViewModel(), savedViewModel: savedViewModel)
            }
            
            Tab("Saved", systemImage: "bookmark", value: TabItem.saved) {
                SavedView(savedViewModel: savedViewModel)
            }
        }
        .tint(.primary)
    }
}

#Preview {
    TabBarView()
}

