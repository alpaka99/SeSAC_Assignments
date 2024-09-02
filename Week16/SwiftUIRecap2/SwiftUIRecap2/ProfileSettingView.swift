//
//  ProfileSettingView.swift
//  SwiftUIRecap2
//
//  Created by user on 9/2/24.
//

import SwiftUI

struct ProfileSettingView: View {
    
    @State private var selectedImage = ProfileImage.randomImage()
    
    var body: some View {
        VStack {
            CircleImageView(image: Image(selectedImage.imageName))
                .frame(maxWidth: 100)
                .overlay {
                    
                }
                
                
        }
        .navigationTitle("PROFILE SETTING")
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    ProfileSettingView()
}
