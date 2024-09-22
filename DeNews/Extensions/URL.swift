//
//  URL.swift
//  DeNews
//
//  Created by Deniz Dilbilir on 25/11/2024.
//

import Foundation

extension URL: @retroactive Identifiable {
    public var id: String { absoluteString }
}
