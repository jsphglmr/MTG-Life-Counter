//
//  SetupScreenView.swift
//  MTG Life Counter
//
//  Created by Joseph Gilmore on 11/2/25.
//

import SwiftUI

struct SetupScreenView: View {
    @Environment(Router.self) var router
    @State private var connectionViewModel = ConnectionViewModel()
    
    var body: some View {
        let columns = [
            GridItem(.flexible(), spacing: 10),
            GridItem(.flexible(), spacing: 10)
        ]
        
        GeometryReader { geometry in
            VStack {
                if connectionViewModel.isConnected {
                    Text("Warning: No internet connection!")
                        .foregroundStyle(Color.yellow)
                        .font(.title2)
                } else {
                    Text("")
                        .font(.headline)
                        .padding(.top, 10)
                }
                Spacer()
                Text("How many players?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(.bottom, 25)
                LazyVGrid(columns: columns, spacing: 25) {
                    ForEach(1..<5) { playerCount in
                        Button(action: { router.navigateToGameView(playerCount: playerCount) }) {
                            VStack {
                                // player count header
                                Text("\(playerCount)")
                                    .font(.system(size: 60, weight: .bold, design: .rounded))
                                
                                Text(playerCount == 1 ? "Player" : "Players")
                                    .font(.caption)
                                    
                            }
                            .frame(width: (geometry.size.width / 2.2), height: (geometry.size.height / 4))
                            .foregroundStyle(.white)
                            .background(Color.red.opacity(0.75))
                            .containerShape(.rect(cornerRadius: 24))
                        }
                    }
                }
                Spacer()
            }
            .background(Color.black)
            .task {
                await connectionViewModel.checkInternet()
            }
        }
    }
}

#Preview {
    SetupScreenView()
        .environment(Router())
}
