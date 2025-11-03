//
//  SetupScreenView.swift
//  MTG Life Counter
//
//  Created by Joseph Gilmore on 11/2/25.
//

import SwiftUI

struct SetupScreenView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("How many players?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(.bottom, 50)
                
                VStack(alignment: .center, spacing: 20) {
                    ForEach(2..<5) { playerCount in
                        NavigationLink(value: playerCount) {
                            VStack {
                                // player count header
                                Text("\(playerCount)")
                                    .font(.system(size: 60, weight: .bold, design: .rounded))
                                    .foregroundStyle(.black)
                                
                                // change this to player(s) if single player ever added
                                Text("Players")
                                    .font(.caption)
                                    .foregroundStyle(.black)
                            }
                            .frame(width: geometry.size.width, height: 120)
                            .background(Color.white)
                            .containerShape(.rect(cornerRadius: 24))
                        }
                    }
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
        }
    }
}

#Preview {
    SetupScreenView()
}
