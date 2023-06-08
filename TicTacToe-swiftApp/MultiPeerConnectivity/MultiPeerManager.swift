//
//  MultiPeerManager.swift
//  TicTacToe-swiftApp
//
//  Created by Sayor Debbarma on 08/06/23.
//

import MultipeerConnectivity

extension String {
    static var serviceName = "XAndO"
}

class MPConnectionManager: NSObject, ObservableObject {
    let serviceType = String.serviceName
    let session: MCSession
    let myPeerId: MCPeerID
    let nearbyServiceAdvertiser: MCNearbyServiceAdvertiser
    let nearbyServiceBrowser: MCNearbyServiceBrowser
    
    init(yourName: String) {
        myPeerId = MCPeerID(displayName: yourName)
        session = MCSession(peer: myPeerId)
        nearbyServiceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerId, discoveryInfo: nil, serviceType: serviceType)
        nearbyServiceBrowser = MCNearbyServiceBrowser(peer: myPeerId, serviceType: serviceType)
    }
    
    deinit {
        stopBrowsing()
        stopAdvertising()
    }
    
    func startAdvertising() {
        nearbyServiceAdvertiser.startAdvertisingPeer()
    }
    func stopAdvertising() {
        nearbyServiceAdvertiser.stopAdvertisingPeer()
    }
    func startBrowsing() {
        nearbyServiceBrowser.startBrowsingForPeers()
    }
    func stopBrowsing() {
        nearbyServiceBrowser.stopBrowsingForPeers()
    }
}
