//
//  DetailRandomImageView.swift
//  SwiftUIRecap2
//
//  Created by user on 9/6/24.
//

import SwiftUI

struct DetailRandomImageView: View {
    @Binding var imageData: ImageData
    var body: some View {
        VStack {
            Image(uiImage: UIImage(data: imageData.data) ?? UIImage(systemName: "star.fill")!)
            TextField("제목을 입력해주세요", text: $imageData.title)
        }
    }
}
