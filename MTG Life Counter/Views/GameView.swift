//
//  GameView.swift
//  MTG Life Counter
//
//  Created by Joseph Gilmore on 11/2/25.
//

import SwiftUI

struct GameView: View {
    var playerCount: Int
    @Environment(Router.self) var router
    
    var body: some View {
        GeometryReader { geometry in
            
            ZStack {
                if playerCount == 1 {
                    menuButton
                        .position(x: geometry.size.width - 50, y: 25)
                } else {
                    menuButton
                        .frame(width: 75, height: 75)
                }
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
        }
        // TODO: remove once done
        .navigationBarBackButtonHidden()
        .background(Color.black)
    }
    
    //MARK: 1 - 4 player layouts
    private func singlePlayerLayout(geometry: GeometryProxy) -> some View {
        ZStack {
            PlayerHealthView(player: Player.testPlayerData())
                .frame(width: geometry.size.width, height: geometry.size.height / 2)
                .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.5)
        }
    }
    
    private func twoPlayerLayout(geometry: GeometryProxy) -> some View {
        ZStack{
            // top
            PlayerHealthView(player: Player.testPlayerData())
                .rotationEffect(.degrees(180))
                .frame(width: geometry.size.width, height: geometry.size.height / 2)
                .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.2)
            
            // bottom
            PlayerHealthView(player: Player.testPlayerData())
                .frame(width: geometry.size.width, height: geometry.size.height / 2)
                .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.8)
        }
    }
    
    private func threePlayerLayout(geometry: GeometryProxy) -> some View {
        ZStack {
            // bottom left
            PlayerHealthView(player: Player.testPlayerData())
                .rotationEffect(.degrees(90))
                .frame(width: geometry.size.width / 1.05, height: geometry.size.height / 4)
                .position(x: geometry.size.width * 0.25, y: geometry.size.height * 0.75)
            
            // bottom right
            PlayerHealthView(player: Player.testPlayerData())
                .rotationEffect(.degrees(-90))
                .frame(width: geometry.size.width / 1.05, height: geometry.size.height / 4)
                .position(x: geometry.size.width * 0.75, y: geometry.size.height * 0.75)
            
            // top
            PlayerHealthView(player: Player.testPlayerData())
                .rotationEffect(.degrees(180))
                .frame(width: geometry.size.width, height: geometry.size.height / 3)
                .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.2)
        }
    }
    
    private func fourPlayerLayout(geometry: GeometryProxy) -> some View {
        ZStack {
            // bottom left
            PlayerHealthView(player: Player.testPlayerData())
                .rotationEffect(.degrees(90))
                .frame(width: geometry.size.width / 1.05, height: geometry.size.height / 4)
                .position(x: geometry.size.width * 0.25, y: geometry.size.height * 0.75)
            
            // bottom right
            PlayerHealthView(player: Player.testPlayerData())
                .rotationEffect(.degrees(-90))
                .frame(width: geometry.size.width / 1.05, height: geometry.size.height / 4)
                .position(x: geometry.size.width * 0.75, y: geometry.size.height * 0.75)
        
            // top left
            PlayerHealthView(player: Player.testPlayerData())
                .rotationEffect(.degrees(90))
                .frame(width: geometry.size.width / 1.05, height: geometry.size.height / 4)
                .position(x: geometry.size.width * 0.25, y: geometry.size.height * 0.25)
            
            // top right
            PlayerHealthView(player: Player.testPlayerData())
                .rotationEffect(.degrees(-90))
                .frame(width: geometry.size.width / 1.05, height: geometry.size.height / 4)
                .position(x: geometry.size.width * 0.75, y: geometry.size.height * 0.25)
        }
    }
    
    // MARK: - Menu Button
    private var menuButton: some View {
        Button {
            router.navigateToMenu()
        } label: {
            ZStack {
                Circle()
                    .fill(Color.black)
                    .frame(width: 80, height: 80)
                
//                Circle()
//                    .stroke(Color.white, lineWidth: 2)
//                    .frame(width: 80, height: 80)
                
                Image(systemName: "gearshape")
                    .font(.system(size: 60
                                  , weight: .ultraLight, design: .default))
                    .foregroundColor(.white.opacity(0.5))
            }
        }
    }
}

#Preview {
    GameView(playerCount: 1)
        .environment(Router())
}
