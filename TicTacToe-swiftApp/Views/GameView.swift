//
//  GameView.swift
//  TicTacToe-swiftApp
//
//  Created by Sayor Debbarma on 25/05/23.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var game: GameService
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            if [game.player1.isCurrect, game.player2.isCurrect].allSatisfy({$0 == false}) { // $0 == false to check both player are false
                Text("Select players")
                HStack {
                    Button(game.player1.name) {
                        game.player1.isCurrect = true
                    }
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                        .fill(game.player1.isCurrect ? Color.green : Color.gray)
                    )
                    .foregroundColor(.white)
                    Button(game.player2.name) {
                        game.player2.isCurrect = true
                    }
                }
                .disabled(game.gameStarted)
                Spacer()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("End Game") {
                    dismiss()
                }
                .buttonStyle(.bordered)
            }
        }
        .navigationTitle("Tic Tac Toe")
        .inNavigationStack()
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(GameService())
    }
}
