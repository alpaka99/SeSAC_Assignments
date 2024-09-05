//
//  RandomImageView.swift
//  SwiftUIRecap2
//
//  Created by user on 9/5/24.
//

import SwiftUI

struct RandomImageView:
    View {
    @State private var imageDataArray: [ImageData] = []
    
    let gridItems: [GridItem] = [
        GridItem(.flexible(minimum: 30, maximum: 400)),
        GridItem(.flexible(minimum: 30, maximum: 400)),
        GridItem(.flexible(minimum: 30, maximum: 400))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: gridItems) {
                    ForEach($imageDataArray) { $imageData in
                        VStack {
                            NavigationLink {
                                NavigationLazyView(wrappedView: DetailRandomImageView(imageData: $imageData))
                            } label: {
                                VStack {
                                    Image(uiImage: UIImage(data: imageData.data) ?? UIImage(systemName: "star.fill")!)
                                        .resizable()
                                    Text(imageData.title)
                                }
                            }
                            .background(.red)
                        }
                    }
                }
            }
                
            }
            .task {
                await fetchImageGroup()
            }
            .refreshable {
                await fetchImageGroup()
            }
    }
    
    func fetchImageGroup() async {
        do {
            imageDataArray = try await PicsumAPI.shared.requestPicsumData(of: 10)
        } catch {
            print("Image fetch error")
        }
    }
}

#Preview {
    RandomImageView()
}

struct ImageData: Hashable, Identifiable {
    let id = UUID()
    let data: Data
    var title: String
}


