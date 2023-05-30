//
//  GameService.swift
//  TicTacToe-swiftApp
//
//  Created by Sayor Debbarma on 30/05/23.
//

import Foundation

@MainActor
class GameService: ObservableObject {
    @Published var player1 = Player(gamePiece: .x, name: "Player 1")
    @Published var player2 = Player(gamePiece: .x, name: "Player 2")
    @Published var possibleMoves = Move.all
    @Published var movesTaken = [Int]()
    @Published var gameOver = false
    
    var gameType = GameType.single
    
    var currentPlayer: Player {
        if player1.isCurrect {
            return player1
        } else {
            return player2
        }
    }
    
    var gameStarted: Bool {
        player1.isCurrect || player2.isCurrect
    }
    
    var boardDisabled: Bool {
        gameOver || !gameStarted
    }
    
    func setupGame(gametype: GameType, player1Name: String, player2Name: String) {
        switch gameType {
        case .single:
            gameType = .single
            player2.name = player2Name
        case .bot:
            gameType = .bot
        case .peer:
            gameType = .peer
        case .undetermined:
            break
        }
        player1.name = player1Name
    }
    
    func resetGame() {
        player1.isCurrect = false
        player2.isCurrect = false
        movesTaken.removeAll()
        player1.moves.removeAll()
        player2.moves.removeAll()
        gameOver = false
        possibleMoves = Move.all
    
    }
}
