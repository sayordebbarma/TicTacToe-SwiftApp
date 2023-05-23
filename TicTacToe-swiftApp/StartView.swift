//
//  ContentView.swift
//  TicTacToe-swiftApp
//
//  Created by Sayor Debbarma on 22/05/23.
//

import SwiftUI

struct StartView: View {
    @State private var gameType: GameType = .undetermined
    @State private var yourName = ""
    @State private var opponentName = ""
    @FocusState private var focus: Bool
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
            .accentColor(.accentColor)
            Text(gameType.description)
                .padding()
            VStack {
                switch gameType {
                case .single:
                    VStack {
                        TextField("Your name: ", text: $yourName)
                        TextField("Opponent name: ", text: $opponentName)
                    }
                case .bot:
                    TextField("Your name: ", text: $yourName)
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
                    focus = false
                }
                .buttonStyle(.borderedProminent)
                .disabled (
                    gameType == .undetermined || gameType == .bot && yourName.isEmpty ||
                    gameType == .single && (yourName.isEmpty || opponentName.isEmpty)
                )
                //Image()
            }
            Spacer()
            
        }
        .padding()
    }
}

struct StratView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
