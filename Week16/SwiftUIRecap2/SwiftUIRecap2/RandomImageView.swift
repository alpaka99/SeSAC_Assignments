//
//  RandomImageView.swift
//  SwiftUIRecap2
//
//  Created by user on 9/5/24.
//

import SwiftUI

struct RandomImageView:
    View {
    @State private var data: Data = Data()
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0..<4) { _ in
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(0..<10) { _ in
                                AsyncImage(url: URL(string: "https://picsum.photos/200/300"))
                            }
                        }
                    }
                }
            }
        }
        
//            .task {
//                do {
//                    data = try await PicsumAPI.shared.requestPicsumData()
//                } catch {
//                    print("Image fetch error")
//                }
//            }
    }
}

#Preview {
    RandomImageView()
}

struct ImageData {
    let url = "https://picsum.photos/200/300"
    let title: String
}
