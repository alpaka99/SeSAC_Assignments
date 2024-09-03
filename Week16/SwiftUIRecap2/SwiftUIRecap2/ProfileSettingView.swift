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
                CircleImageView(image: Image(selectedImage.imageName), isSelected: true)
                    .frame(maxWidth: 100)
                    .overlay(alignment: .bottomTrailing) {
                        CircleImageView(image: Image(systemName: "camera"), isSelected: true)
                            .frame(width: 30)
                    }
            }
            .padding(.vertical)
                
            TextField("닉네임을 입력하세요 :)", text: $nickname)
                .bold()
                .padding(16)
                .foregroundStyle(.gray)
            
            Divider()
                .padding(.horizontal, 16)
            
            Spacer()
            
            HStack {
                Text("MBTI")
                    .bold()
                    .font(.title2)
                    .padding()
                
                Spacer()
                
                MBTIView()
                    .frame(maxWidth: 200)
                    .padding()
            }
            
            Spacer()
            
            NavigationLink {
                LastView()
            } label: {
                Text("완료")
            }
            .disabled(nickname.isEmpty)
            .asRoundButton(nickname.isEmpty ? .gray : .blue)
            .padding(.vertical)
            
            
        }
        .navigationTitle("PROFILE SETTING")
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    ProfileSettingView()
}
