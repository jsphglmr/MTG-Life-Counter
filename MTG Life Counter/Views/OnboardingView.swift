//
//  OnboardingView.swift
//  MTG Life Counter
//
//  Created by Joseph Gilmore on 11/2/25.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(Router.self) var router
    
    var body: some View {
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
                        .monospaced()
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("A battery conscious life counter to simplify your real life Magic: The Gathering games!")
                        .monospaced()
                        .multilineTextAlignment(.center)
                        .font(.title2)
                }
                .foregroundStyle(Color.white)
                .padding()
                Spacer()
                VStack(alignment: .center, spacing: 25) {
                    Button {
                        router.navigateToSetupView()
                    } label: {
                        Text("Continue")
                            .monospaced()
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
                Spacer()
            }
        }
        .background(Color.black)
    }
}

#Preview {
    OnboardingView()
        .environment(Router())
}
