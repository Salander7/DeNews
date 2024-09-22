//
//  SearchBarView.swift
//  DeNews
//
//  Created by Deniz Dilbilir on 23/09/2024.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var search: String

    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
        
                if search.isEmpty {
                    Text("Search")
                        .foregroundStyle(.secondary)
                        .padding(.leading, 40)
                }
                
                TextField("", text: $search)
                    .autocorrectionDisabled(true)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(.leading, 40)
                     .overlay(
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.secondary)
                            .padding(.leading, 8),
                        alignment: .leading
                    )
            }
            .padding(8)
            .background(Color.secondary.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(
            
                Image(systemName: "xmark.circle")
                    .foregroundStyle(.secondary)
                    .opacity(search.isEmpty ? 0 : 1)
                    .padding(.trailing, 8)
                    .onTapGesture {
                        search = ""
                    },
                alignment: .trailing
            )
        }
    }
}

#Preview {
    SearchBarView(search: .constant(""))
}

