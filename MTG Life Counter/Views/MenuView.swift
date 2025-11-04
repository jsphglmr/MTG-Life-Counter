//
//  MenuView.swift
//  MTG Life Counter
//
//  Created by Joseph Gilmore on 11/3/25.
//

import SwiftUI

struct MenuView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(Router.self) var router
    @State private var showingResetAlert = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Text("Menu")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                VStack(spacing: 20) {
                    // reset button
                    Button {
                        showingResetAlert = true
                    } label: {
                        HStack {
                            Image(systemName: "arrow.clockwise")
                            Text("End Game")
                        }
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(12)
                    }
                    
                    // continue button
                    Button {
                        dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "play.fill")
                            Text("Return to Game")
                        }
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                    }
                }
                .padding(.horizontal, 40)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
//            .navigationBarTitleDisplayMode(.inline)
        }
        .alert("End Game?", isPresented: $showingResetAlert) {
            Button("End", role: .destructive) {
                router.popToRoot()
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("This will end the current game and return to the main menu. Are you sure you want to end the game?")
        }
    }
}

#Preview {
    MenuView()
        .environment(Router())
}
