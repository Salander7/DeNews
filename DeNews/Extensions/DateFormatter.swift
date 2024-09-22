//
//  DateFormatter.swift
//  DeNews
//
//  Created by Deniz Dilbilir on 26/09/2024.
//

import Foundation

extension String {
    func formattedDate() -> String? {
        let formatter = ISO8601DateFormatter()
        guard let date = formatter.date(from: self)
        else {
            return nil
        }
        let displayFormatter = DateFormatter()
        displayFormatter.dateStyle = .medium
        return displayFormatter.string(from: date)
    }
}
