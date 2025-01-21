//
//  DeNewsApp.swift
//  DeNews
//
//  Created by Deniz Dilbilir on 20/09/2024.
//

import SwiftUI
import SwiftData

@main
struct DeNewsApp: App {
    var body: some Scene {
        WindowGroup {
            TabBarView()
        }
        .modelContainer(for: [SavedArticle.self])
    }
}
