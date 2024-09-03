//
//  ProfileSelectionView.swift
//  SwiftUIRecap2
//
//  Created by user on 9/2/24.
//

import SwiftUI

struct ProfileSelectionView: View {
    @Binding var selectedProfileImage: ProfileImage
    
    var columns: [GridItem] = Array(repeating: .init(.flexible(minimum: 80, maximum: 100)), count: 3)
    
    var body: some View {
        VStack {
            CircleImageView(image: Image(selectedProfileImage.imageName), isSelected: true)
                .frame(maxWidth: 100)
            
            LazyVGrid(columns: columns) {
                ForEach(ProfileImage.allCases, id: \.self) { profileImage in
                    CircleImageView(image: Image(profileImage.imageName), isSelected: false)
                        .onTapGesture {
                            print("tapped")
                            selectedProfileImage = profileImage
                        }
                        .padding()
                }
            }
            
            Spacer()
            
        }
    }
}

#Preview {
    ProfileSelectionView(selectedProfileImage: .constant(ProfileImage.randomImage()))
}
