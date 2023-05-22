//
//  GameModels.swift
//  TicTacToe-swiftApp
//
//  Created by Sayor Debbarma on 22/05/23.
//

import Foundation

enum gameType {
    case single, bot, peer, undetermined
    
    var description: String {
        switch self {
        case .single:
            return "Share your iphone/ipad to play against a friend"
        case .bot:
            return "play against iphone/ipad"
        case .peer:
            return "play against near by friend"
        case .undetermined:
            return ""
        }
    }
}
