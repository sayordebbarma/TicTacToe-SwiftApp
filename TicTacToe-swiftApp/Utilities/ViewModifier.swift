//
//  ViewModifier.swift
//  TicTacToe-swiftApp
//
//  Created by Sayor Debbarma on 24/05/23.
//

import SwiftUI

struct navStackContainer: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16, *) {
            NavigationStack {
                content
            }
        } else {
            NavigationView {
                content
            }
            .navigationViewStyle(.stack)
        }
    }
}

extension View {
    public func inNavigationStack() -> some View {
        return self.modifier(navStackContainer())
    }
}
