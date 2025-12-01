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
        formatter.numberStyle = .none
        return formatter
    }()
    
    var body: some View {
        if player.isDead {
            DeadView(player: player)
        } else {
            aliveView
        }
    }
    
    private var aliveView: some View {
        GeometryReader { geometry in
            HStack {
                Button {
                    player.health -= 1
                } label: {
                    Rectangle()
                        .fill(Color.clear)
                        .overlay(
                            Image(systemName: "minus")
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(.white))
                }
                .contentShape(Rectangle())
                .buttonRepeatBehavior(.enabled)
                
                TextField("\(player.health)", value: $player.health, formatter: formatter)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 45, weight: .black, design: .monospaced))
                    .fontWeight(.ultraLight)
                    .keyboardType(.numberPad)
                    .frame(width: 120)
                
                Button {
                    player.health += 1
                } label: {
                    Rectangle()
                        .fill(Color.clear)
                        .overlay(
                            Image(systemName: "plus")
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(.white))
                }
                .contentShape(Rectangle())
                .buttonRepeatBehavior(.enabled)
            }
            if player.health <= 0 {
                Button("dead?") {
                    player.isDead = true
                }
                .font(.system(size: 16, weight: .light, design: .monospaced))
                .fontWeight(.bold)
                .foregroundColor(.red)
                .padding(.horizontal, 20)
                .padding(.vertical,4)
                .background(Color.red.opacity(0.2))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.red, lineWidth: 2)
                )
                .position(x: geometry.size.width / 2, y: geometry.size.height/2 + 50)
            }
        }
        .foregroundStyle(.white)
    }
}

#Preview {
    PlayerHealthView(player: Player.testPlayerData())
        .preferredColorScheme(.dark)
}
