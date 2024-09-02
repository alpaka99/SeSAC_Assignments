//
//  ProfileImageView.swift
//  SwiftUIRecap2
//
//  Created by user on 9/2/24.
//

import SwiftUI

struct CircleImageView: View {
    let image: Image
    let isSelected: Bool
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

struct CircleImageModifier: ViewModifier {
    
    let isSelected: Bool
    
    func body(content: Content) -> some View {
        if isSelected {
            return content
        } else {
            return content
        }
    }
}

#Preview {
    CircleImageView(image: Image(systemName: "camera"), isSelected: false)
}
