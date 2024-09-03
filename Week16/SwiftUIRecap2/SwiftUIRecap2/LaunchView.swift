//
//  LaunchView.swift
//  SwiftUIRecap2
//
//  Created by user on 9/2/24.
//

import SwiftUI

struct LaunchView: View {
    
    @State private var launchScreenOpacity: Double = 0.0
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Image("launch")
                    .padding()
                
                Spacer()
                Image("launchImage")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                
                Spacer()
                NavigationLink {
                    ProfileSettingView()
                } label: {
                    Text("시작하기")
                        .bold()
                        .font(.headline)
                }
                .asRoundButton(.blue)
            }
            .opacity(launchScreenOpacity)
            .onAppear {
                withAnimation {
                    launchScreenOpacity = 1
                }
            }
        }
    }
}

struct RoundButtonModifer: ViewModifier {
    let color: Color
    
    func body(content: Content) -> some View {
        content
        .padding()
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .background(color)
        .clipShape(Capsule())
        .padding()
    }
}

extension View {
    func asRoundButton(_ color: Color) -> some View {
        modifier(RoundButtonModifer(color: color))
    }
}

#Preview {
    LaunchView()
}
