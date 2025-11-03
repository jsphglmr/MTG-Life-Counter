//
//  GameView.swift
//  MTG Life Counter
//
//  Created by Joseph Gilmore on 11/2/25.
//

import SwiftUI

struct GameView: View {
    var playerCount: Int
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                switch playerCount {
                case 1:
                    singlePlayerLayout(geometry: geometry)
                case 2:
                    twoPlayerLayout(geometry: geometry)
                case 3:
                    threePlayerLayout(geometry: geometry)
                case 4:
                    fourPlayerLayout(geometry: geometry)
                default:
                    EmptyView()
                    
                }
            }
        }
        .background(Color.black)
    }
    
    
    private func singlePlayerLayout(geometry: GeometryProxy) -> some View {
        PlayerHealthView(player: Player.testPlayerData())
    }
    
    private func twoPlayerLayout(geometry: GeometryProxy) -> some View {
        ZStack{
            PlayerHealthView(player: Player.testPlayerData())
            PlayerHealthView(player: Player.testPlayerData())
        }
    }
    
    private func threePlayerLayout(geometry: GeometryProxy) -> some View {
        ZStack {
            PlayerHealthView(player: Player.testPlayerData())
            PlayerHealthView(player: Player.testPlayerData())
            PlayerHealthView(player: Player.testPlayerData())
        }
    }
    
    private func fourPlayerLayout(geometry: GeometryProxy) -> some View {
        ZStack {
            PlayerHealthView(player: Player.testPlayerData())
            PlayerHealthView(player: Player.testPlayerData())
            PlayerHealthView(player: Player.testPlayerData())
            PlayerHealthView(player: Player.testPlayerData())
        }
    }
    
    
}

#Preview {
    GameView(playerCount: 4)
}
