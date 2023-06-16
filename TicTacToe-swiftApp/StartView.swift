//
//  ContentView.swift
//  TicTacToe-swiftApp
//
//  Created by Sayor Debbarma on 22/05/23.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var game: GameService
    @State private var gameType: GameType = .undetermined
    @AppStorage("yourName") var yourName = ""
    @State private var opponentName = ""
    @FocusState private var focus: Bool
    @State private var StartGame = false
    @State private var changeName = false
    @StateObject var connectionManager: MPConnectionManager
    @State private var newName = ""
    init(yourName: String) {
        self.yourName = yourName
        _connectionManager = StateObject(wrappedValue: MPConnectionManager(yourName: yourName))
    }
    var body: some View {
        VStack {
            Picker("Select game type ",  selection: $gameType) {
                Text("Select game type ").tag(GameType.undetermined)
                Text("Play together ").tag(GameType.single)
                Text("Play against computer ").tag(GameType.bot)
                Text("Play against your friend ").tag(GameType.peer)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(lineWidth: 2))
            Text(gameType.description)
                .padding()
            VStack {
                switch gameType {
                case .single:
                        TextField("Opponent name: ", text: $opponentName)
                case .bot:
                    EmptyView()
                case .peer:
                    EmptyView()
                case .undetermined:
                    EmptyView()
                }
            }
            .padding()
            .textFieldStyle(.roundedBorder)
            .frame(width: 350)
            .focused($focus)
            
            if gameType != .peer {
                Button("Start game") {
                    game.setupGame(gametype: gameType, player1Name: yourName, player2Name: opponentName)
                    focus = false
                    StartGame.toggle()
                }
                .buttonStyle(.borderedProminent)
                .disabled (
                    gameType == .undetermined || gameType == .single && opponentName.isEmpty
                )
                //Image()
                Text("My current name is \(yourName)")
                Button("Change my name") {
                    changeName.toggle()
                }
                .buttonStyle(.bordered)
            }
            Spacer()
            
        }
        .padding()
        .navigationTitle("Tic Tac Toe")
        .fullScreenCover(isPresented: $StartGame){
            GameView()
                .environmentObject(connectionManager)
        }
        .alert("Change Name", isPresented: $changeName, actions: {
            TextField("New name", text: $newName)
            Button("OK", role: .destructive) {
                yourName = newName
                exit(-1)
            }
            Button("Cancel", role: .cancel) {}
        }, message: {
            Text("Tap OK to change your name")
        })
        .inNavigationStack()
    }
}

struct StratView_Previews: PreviewProvider {
    static var previews: some View {
        StartView(yourName: "yourName")
            .environmentObject(GameService())
    }
}
