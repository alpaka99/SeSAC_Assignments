//
//  RandomImageView.swift
//  SwiftUIRecap2
//
//  Created by user on 9/5/24.
//

import SwiftUI

struct RandomImageView:
    View {
    @State private var dataArray: [Data] = []
    
    let gridItems: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItems) {
                
                ForEach(dataArray, id: \.self) { data in
                    Image(uiImage: UIImage(data: data) ?? UIImage(systemName: "star.fill")!)
                }
            }
                
            }
            .task {
                do {
                    dataArray = try await PicsumAPI.shared.requestPicsumData(of: 10)
                } catch {
                    print("Image fetch error")
                }
            }
    }
}

#Preview {
    RandomImageView()
}

struct ImageData {
    let url = "https://picsum.photos/200/300"
    let title: String
}
