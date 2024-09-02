//
//  ProfileSettingView.swift
//  SwiftUIRecap2
//
//  Created by user on 9/2/24.
//

import SwiftUI

struct ProfileSettingView: View {
    
    @State private var selectedImage = ProfileImage.randomImage()
    @State private var nickname = ""
    
    var body: some View {
        VStack {
            NavigationLink {
                ProfileSelectionView(selectedProfileImage: $selectedImage)
            } label: {
                CircleImageView(image: Image(selectedImage.imageName))
                    .frame(maxWidth: 100)
                    .overlay(alignment: .bottomTrailing) {
                        CircleImageView(image: Image(systemName: "camera"))
                            .frame(width: 30)
                    }
            }
                
            TextField("닉네임을 입력하세요 :)", text: $nickname)
                .bold()
                .padding()
                .foregroundStyle(.gray)
            
            Divider()
                .padding(.horizontal)
            
            
            HStack {
                Text("MBTI")
                    .bold()
                    .font(.title2)
                    .padding()
                
                Spacer()
            }
            
            
        }
        .navigationTitle("PROFILE SETTING")
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    ProfileSettingView()
}
