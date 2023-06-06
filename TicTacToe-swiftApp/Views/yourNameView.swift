//
//  yourNameView.swift
//  TicTacToe-swiftApp
//
//  Created by Sayor Debbarma on 06/06/23.
//

import SwiftUI

struct yourNameView: View {
    @AppStorage("yourName") var yourName = ""
    @State private var userName = ""
    var body: some View {
        VStack {
            Image("LaunchScreen")
            Text("Name associated with this device")
            TextField("yourName", text: $userName)
                .textFieldStyle(.roundedBorder)
            Button("Set") {
                yourName = userName
            }
            .buttonStyle(.borderedProminent)
            .disabled(userName.isEmpty)
            Spacer()
        }
        .padding()
        .navigationTitle("Tic Tac Toe")
        .inNavigationStack()
    }
}

struct yourNameView_Previews: PreviewProvider {
    static var previews: some View {
        yourNameView()
    }
}
