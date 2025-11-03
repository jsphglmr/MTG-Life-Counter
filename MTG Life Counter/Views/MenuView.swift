//
//  MenuView.swift
//  MTG Life Counter
//
//  Created by Joseph Gilmore on 11/3/25.
//

import SwiftUI

struct MenuView: View {
    @Environment(\.dismiss) private var dismiss
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
                    Button(action: {
                        showingResetAlert = true
                    }) {
                        HStack {
                            Image(systemName: "arrow.clockwise")
                            Text("Reset Game")
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
                    Button(action: {
                        dismiss()
                    }) {
                        HStack {
                            Image(systemName: "play.fill")
                            Text("Continue Game")
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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .foregroundColor(.white)
                }
            }
        }
        .alert("Reset Game?", isPresented: $showingResetAlert) {
            Button("Reset", role: .destructive) {
                resetGame()
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("This will end the current game and return to the main menu. All progress will be lost.")
        }
        .onAppear {
            // Keep screen awake while menu is open
            UIApplication.shared.isIdleTimerDisabled = true
        }
        .onDisappear {
            // Re-enable auto-lock when leaving menu
            UIApplication.shared.isIdleTimerDisabled = false
        }
    }
    
    private func resetGame() {
        // Dismiss the menu first
        dismiss()
        
        // Navigate back to setup screen
        // This will be handled by the parent view
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // Post notification or use environment to trigger reset
            NotificationCenter.default.post(name: .resetGame, object: nil)
        }
    }
}

// reset game extn
extension Notification.Name {
    static let resetGame = Notification.Name("resetGame")
}


#Preview {
    MenuView()
}
