//
//  MPGameMove.swift
//  TicTacToe-swiftApp
//
//  Created by Sayor Debbarma on 11/06/23.
//

import Foundation

struct MPGameMove: Codable {
    enum Action: Int, Codable {
        case start, move, reset, end
    }
    let action: Action
    let playerName: String
    let index: Int
    
    func data() -> Data? {
        try? JSONEncoder().encode(self)
    }
}
