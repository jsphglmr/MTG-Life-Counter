//
//  OnboardingView.swift
//  MTG Life Counter
//
//  Created by Joseph Gilmore on 11/2/25.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack(alignment: .center) {
                    ZStack {
                        Circle()
                            .padding(20)
                            .foregroundStyle(.red)
                        Image(systemName: "wand.and.stars")
                            .imageScale(.large)
                            .shadow(radius: 10,  x: 5, y: 10)
                    }
                    .font(.system(size: 100))
                    .fontWeight(.black)
                    .foregroundStyle(.white)
                    VStack(alignment: .center) {
                        Text("MTG Commander LT")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text("A battery conscious life counter to simplify your real life Magic: The Gathering games!")
                            .font(.title2)
                    }
                    .foregroundStyle(Color.white)
                    .padding()
                    
                    VStack(alignment: .center, spacing: 25) {
                        NavigationLink(destination: SetupScreenView()) {
                            Text("Continue")
                                .font(.title)
                                .fontWeight(.bold)
                        }
                    }
                    .padding()
                    .frame(maxWidth: geometry.size.width)
                    .padding()
                    .foregroundStyle(.white)
                    .background(LinearGradient(colors: [.white, .red, .red, .red, .orange], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .containerShape(.rect(cornerRadius: 24))
                }
            }
            .background(Color.black)
        }
    }
}

#Preview {
    OnboardingView()
}
