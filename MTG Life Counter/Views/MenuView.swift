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
    @State private var diceViewModel = DiceViewModel()
    @State private var showingResetAlert = false
    @State private var showingDiceMenu = false
    @State private var diceResults: [String?] = [nil, nil, nil, nil]
    @State private var selectedDiceIndex: Int? = nil
    let diceMenuItems: [String] = ["Coin Flip", "D4", "D6", "D20"]
    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]

    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack(spacing: 30) {
                    Text("Menu")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    VStack(spacing: 20) {
                        // roll dice
                        rollDiceButton(geometry: geometry)
                        Spacer()
                        
                        // return button
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
                        
                        // end button
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
    
    private func resetDice() {
        for index in 0..<4 {
            diceResults[index] = nil
        }
    }
    
    private func rollDiceButton(geometry: GeometryProxy) -> some View {
        Button {
            showingDiceMenu = true
        } label: {
            HStack {
                Image(systemName: "dice.fill")
                Text("Roll Dice")
            }
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .sheet(isPresented: $showingDiceMenu) {
                diceMenuView(geometry: geometry)
            }
        }
    }
    
    private func diceMenuView(geometry: GeometryProxy) -> some View {
        LazyVGrid(columns: columns, spacing: 30) {
            ForEach(0..<4) { diceNumber in
                Button {
                    selectedDiceIndex = diceNumber
                } label: {
                    ZStack {
                        Image(systemName: "dice.fill")
                            .font(.system(size: 120, weight: .light))
                            .opacity(0.4)
                        Text(diceResults[diceNumber] ?? diceMenuItems[diceNumber])
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                    }
                    .frame(width: (geometry.size.width / 2.25), height: (geometry.size.height / 5))
                    .foregroundStyle(.white)
                    .background(Color.red)
                    .containerShape(.rect(cornerRadius: 24))
                }
            }
        }
        .preferredColorScheme(.dark)
        .presentationDetents([.height(500), .medium, .large])
        .presentationDragIndicator(.automatic)
        .task(id: selectedDiceIndex) {
            guard let index = selectedDiceIndex else { return }
            
            switch index {
            case 0: // Coin Flip
                await diceViewModel.rollDice(min: 0, max: 1)
                let result: Int = diceViewModel.diceRoll.result
                diceResults[index] = result == 0 ? "Heads" : "Tails"
            case 1: // D4
                await diceViewModel.rollDice(min: 1, max: 4)
                let result: Int = diceViewModel.diceRoll.result
                diceResults[index] = "\(result)"
            case 2: // D6
                await diceViewModel.rollDice(min: 1, max: 6)
                let result: Int = diceViewModel.diceRoll.result
                diceResults[index] = "\(result)"
            case 3: // D20
                await diceViewModel.rollDice(min: 1, max: 20)
                let result: Int = diceViewModel.diceRoll.result
                diceResults[index] = "\(result)"
            default:
                break
            }
            
            // Reset selectedDiceIndex after processing
            selectedDiceIndex = nil
        }
        .onDisappear {
            resetDice()
        }
    }
}

#Preview {
    MenuView()
        .environment(Router())
}
