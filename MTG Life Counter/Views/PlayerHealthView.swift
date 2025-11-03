//
//  PlayerHealthView.swift
//  MTG Life Counter
//
//  Created by Joseph Gilmore on 11/2/25.
//

import SwiftUI

struct PlayerHealthView: View {
    @Bindable var player: Player
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        // implement dead view later
        aliveView
    }
    
    private var aliveView: some View {
        GeometryReader { geometry in
        
            ZStack {
                // minus button
                Button {
                    player.health -= 1
                    print(player.health)
                } label: {
                    Rectangle()
                        .fill(Color.clear)
                        .overlay(
                            Image(systemName: "minus")
                                .font(.system(size:40, weight:.bold)))
                }
                .frame(width:geometry.size.width/2, height: geometry.size.height)
                .contentShape(Rectangle())
                .buttonRepeatBehavior(.enabled)
                .position(x: geometry.size.width / 4, y: geometry.size.height / 2)

                
                // health text


                // plus button
                Button {
                    player.health += 1
                    print(player.health)
                } label: {
                    Rectangle()
                        .fill(Color.clear)
                        .overlay(
                            Image(systemName: "plus")
                                .font(.system(size:40, weight:.bold)))
                }
                .frame(width:geometry.size.width/2, height: geometry.size.height)
                .contentShape(Rectangle())
                .buttonRepeatBehavior(.enabled)
                .position(x: geometry.size.width * 3/4, y: geometry.size.height / 2)
                
                
            }
            TextField("\(player.health)", value: $player.health, formatter: formatter)
                .frame(width: geometry.size.width)
                .multilineTextAlignment(.center)
                .font(.system(size: 45, weight: .black, design: .monospaced))
                .fontWeight(.ultraLight)
                .keyboardType(.numberPad)
                .position(x: geometry.size.width / 2, y: geometry.size.height/2)
            
        
        }
        
        .background(Color.black)
        .foregroundColor(.white)
    }
}

#Preview {
    PlayerHealthView(player: Player.testPlayerData())
}
