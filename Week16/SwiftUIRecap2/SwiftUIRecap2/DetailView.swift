//
//  DetailView.swift
//  SwiftUIRecap2
//
//  Created by user on 9/4/24.
//

import SwiftUI

struct DetailView: View {
    let market: Market
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(market.koreanName)
                Text(market.englishName)
            }
            
            Text(market.market)
        }
        .padding(40)
        .background {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color.random())
        }
        
    }
    
}

#Preview {
    DetailView(market: Market(market: "안녕세상아", koreanName: "안녕세상아 코인", englishName: "Hello world Coin"))
}
