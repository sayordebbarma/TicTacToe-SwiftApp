//
//  TicTacToe_swiftAppApp.swift
//  TicTacToe-swiftApp
//
//  Created by Sayor Debbarma on 22/05/23.
//

import SwiftUI

@main
struct TicTacToe_swiftAppApp: App {
    @StateObject var game = GameService()
    var body: some Scene {
        WindowGroup {
            StartView()
                .environmentObject(game)
        }
    }
}
