//
//  TicTacToe_swiftAppApp.swift
//  TicTacToe-swiftApp
//
//  Created by Sayor Debbarma on 22/05/23.
//

import SwiftUI

@main
struct TicTacToe_swiftAppApp: App {
    @AppStorage("yourName") var yourName = ""
    @StateObject var game = GameService()
    var body: some Scene {
        WindowGroup {
            if yourName.isEmpty {
                yourNameView()
            } else {
                StartView(yourName: yourName)
                    .environmentObject(game)
            }
        }
    }
}
