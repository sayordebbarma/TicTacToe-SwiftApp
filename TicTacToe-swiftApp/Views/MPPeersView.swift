//
//  MPPeersView.swift
//  TicTacToe-swiftApp
//
//  Created by Sayor Debbarma on 21/06/23.
//

import SwiftUI

struct MPPeersView: View {
    @EnvironmentObject var game: GameService
    @EnvironmentObject var connectionManager: MPConnectionManager
    @Binding var startGame: Bool
    var body: some View {
        VStack {
            Text("Available Players to play")
            List(connectionManager.availablePeers, id: \.self) { peer in
                HStack {
                    Text(peer.displayName)
                    Spacer()
                    Button("Select") {
                        game.gameType = .peer
                        connectionManager.nearbyServiceBrowser.invitePeer(peer, to: connectionManager.session, withContext: nil, timeout: 30)
                        game.player1.name = connectionManager.myPeerId.displayName
                        game.player2.name = peer.displayName
                    }
                    .buttonStyle(.borderedProminent)
                }
                
            }
        }
    }
}

struct MPPeersView_Previews: PreviewProvider {
    static var previews: some View {
        MPPeersView(startGame: .constant(false))
            .environmentObject(GameService())
            .environmentObject(MPConnectionManager(yourName: "Demo"))
    }
}
