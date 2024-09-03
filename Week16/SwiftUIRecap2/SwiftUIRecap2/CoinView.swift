//
//  LastView.swift
//  SwiftUIRecap2
//
//  Created by user on 9/3/24.
//

import SwiftUI

struct CoinView: View {
    @State private var searchText = ""
    @State private var allMarkets: Markets = []
    private var filteredMarkets: Markets {
        if searchText.isEmpty {
            return allMarkets
        }
        
        return allMarkets.filter {
            return $0.koreanName.localizedStandardContains(searchText) || $0.englishName.localizedStandardContains(searchText) || $0.market.localizedStandardContains(searchText)
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(filteredMarkets) { market in
                        RowView(market: market)
                    }
                }
            }
            .task {
                do {
                    allMarkets = try await UpbitAPI.fetchMarket()
                } catch {
                    print("error")
                }
                
            }
            .searchable(text: $searchText, prompt: "Search")
            .navigationTitle("Search")
        }
    }
}

struct RowView: View {
    let market: Market
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(market.koreanName)
                    .fontWeight(.bold)
                Spacer()
                Text("\(market.market)")
            }
            
            Text(market.englishName)
                .font(.caption)
                .foregroundStyle(.gray)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
    }
}

#Preview {
    CoinView()
}
