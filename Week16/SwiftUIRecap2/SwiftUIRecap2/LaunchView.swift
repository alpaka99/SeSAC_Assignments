//
//  LaunchView.swift
//  SwiftUIRecap2
//
//  Created by user on 9/2/24.
//

import SwiftUI

struct LaunchView: View {
    var body: some View {
        NavigationView {
            VStack {
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
            .navigationTitle("some navigationTitle")
        }
    }
}

#Preview {
    LaunchView()
}
