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
    
//    let mbtiComponents = [
//        "E",
//        "I",
//        "S",
//        "N",
//        "F",
//        "T", 
//        "P",
//        "J"
//    ]
    
    let mbtiComponents: [MBTIComponent] = [
        MBTIComponent(text: "E"),
        MBTIComponent(text: "I"),
        MBTIComponent(text: "S"),
        MBTIComponent(text: "N"),
        MBTIComponent(text: "F"),
        MBTIComponent(text: "T"),
        MBTIComponent(text: "P"),
        MBTIComponent(text: "J")
    ]
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                ScrollView(.horizontal) {
                    LazyHGrid(rows: gridItems) {
                        ForEach(mbtiComponents) { component in
                            Button {
                                print(component) // 어떻게 selected 상태로 만들어야할까?
                            } label: {
                                Text(component.text)
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


struct MBTIComponent: Identifiable {
    let id = UUID()
    let text: String
    let isSelected: Bool = false
}

#Preview {
    MBTIView()
}
