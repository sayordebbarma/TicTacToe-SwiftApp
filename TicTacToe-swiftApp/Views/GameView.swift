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
            if [game.player1.isCurrent, game.player2.isCurrent].allSatisfy({$0 == false}) {
                // $0 == false to check both player are false
                Text("Select players")
                HStack {
                    Button(game.player1.name) {
                        game.player1.isCurrent = true
                    }
                    .buttonStyle(playerButtonStyle(isCurrent: game.player1.isCurrent))
                    Button(game.player2.name) {
                        game.player2.isCurrent = true
                        if game.gameType == .bot {
                            Task {
                                await game.deviceMove()
                            }
                        }
                    }
                    .buttonStyle(playerButtonStyle(isCurrent: game.player2.isCurrent))
                }
                .disabled(game.gameStarted)
                VStack {
                    HStack {
                        ForEach(0...2, id: \.self) { index in
                            SquareView(index: index)
                        }
                    }
                    HStack {
                        ForEach(0...2, id: \.self) { index in
                            SquareView(index: index)
                        }
                    }
                    HStack {
                        ForEach(0...2, id: \.self) { index in
                            SquareView(index: index)
                        }
                    }
                }
                .overlay {
                    if game.isThinking {
                        VStack {
                            Text("Thinking...")
                                .foregroundColor(Color(.systemBackground))
                                .background(Rectangle().fill(Color.primary))
                            ProgressView()
                        }
                    }
                }
                .disabled(game.boardDisabled)
                VStack {
                    if game.gameOver {
                        Text("Game Over :(")
                        if game.possibleMoves.isEmpty {
                            Text("Nobody Wins ;(")
                        } else {
                            Text("\(game.currentPlayer.name) Wins^^")
                        }
                        Button("New Match") {
                            game.reset()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                .font(.largeTitle)
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
        .onAppear {
            game.reset()
        }
        .inNavigationStack()
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(GameService())
    }
}

struct playerButtonStyle: ButtonStyle {
    let isCurrent: Bool
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 10)
                .fill(isCurrent ? Color.green : Color.gray)
            )
            .foregroundColor(.white)
    }
}
