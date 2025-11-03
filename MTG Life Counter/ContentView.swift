//
//  ContentView.swift
//  MTG Life Counter
//
//  Created by Joseph Gilmore on 11/2/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var players: [Player]
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
//        NavigationStack(path: $navigationPath) {
//            SetupScreenView()
//                .navigationDestination(for: Int.self) { playerCount in
//                    GameView(playerCount: playerCount)
//            }
//        }
        OnboardingView()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Player.self, inMemory: true)
}
