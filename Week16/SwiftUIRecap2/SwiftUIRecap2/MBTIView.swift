//
//  MBTIView.swift
//  SwiftUIRecap2
//
//  Created by user on 9/3/24.
//

import SwiftUI

struct MBTIView: View {
    let gridItems: [GridItem] = [
        GridItem(.flexible(minimum: 50, maximum: 50), spacing: 0),
        GridItem(.flexible(minimum: 50, maximum: 50), spacing: 0),
    ]
    
    let mbtis = ["E", "I", "S", "N", "F", "T", "P", "J"]
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                ScrollView(.horizontal) {
                    LazyHGrid(rows: gridItems) {
                        ForEach(mbtis, id: \.self) { item in
                            Button {
                                print(item)
                            } label: {
                                Text(String(item))
                                    .foregroundStyle(.gray)
                                    .padding()
                                    .background {
                                        Circle()
                                            .fill(.clear)
                                            .stroke(.gray, lineWidth: 2)
                                    }
                            }
                        }
                    }
                }
                .scrollDisabled(true)
            }
            Spacer()
        }
    }
}


#Preview {
    MBTIView()
}
