//
//  UIApplication.swift
//  DeNews
//
//  Created by Deniz Dilbilir on 23/09/2024.
//

import SwiftUI

extension UIApplication {
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
