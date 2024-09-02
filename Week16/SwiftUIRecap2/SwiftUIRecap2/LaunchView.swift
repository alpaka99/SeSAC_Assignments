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
                .padding()
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .background(.blue)
                .clipShape(Capsule())
                .padding()
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

#Preview {
    LaunchView()
}
