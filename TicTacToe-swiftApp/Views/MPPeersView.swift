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
                .alert("Received invitation from \(connectionManager.receiveInviteForm?.displayName ?? "Unknown")", isPresented: $connectionManager.receiveInvite) {
                    Button("Accept") {
                        if let invitationHandler = connectionManager.invitationHandler {
                            invitationHandler(true, connectionManager.session)
                            game.player1.name = connectionManager.receiveInviteForm?.displayName ?? "Unknown"
                            game.player2.name = connectionManager.myPeerId.displayName
                            game.gameType = .peer
                            
                        }
                    }
                    Button("Reject") {
                        if let invitationHandler = connectionManager.invitationHandler {
                            invitationHandler(false, nil)
                        }
                        
                    }
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
