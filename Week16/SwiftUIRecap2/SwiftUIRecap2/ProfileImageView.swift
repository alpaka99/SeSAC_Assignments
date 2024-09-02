//
//  ProfileImageView.swift
//  SwiftUIRecap2
//
//  Created by user on 9/2/24.
//

import SwiftUI

struct CircleImageView: View {
    let image: Image
    
    var body: some View {
        image
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
            .overlay {
                Circle()
                    .fill(.clear)
                    .stroke(.blue, lineWidth: 8)
            }
    }
}

#Preview {
    CircleImageView(image: Image(ProfileImage.randomImage().imageName))
}
