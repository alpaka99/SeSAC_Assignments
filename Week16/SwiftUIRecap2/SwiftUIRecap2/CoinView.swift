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
    @State private var filteredMarkets: Markets = []
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach($filteredMarkets) { $market in
                        NavigationLink {
                            DetailView(market: $market)
                        } label: {
                            RowView(market: $market)
                        }
                    }
                }
            }
            .background {
                Color.black
                    .ignoresSafeArea()
            }
            .task {
                do {
                    allMarkets = try await UpbitAPI.fetchMarket()
                    filteredMarkets = allMarkets
                } catch {
                    print("error: \(error.localizedDescription)")
                }
                
            }
            .searchable(text: $searchText, prompt: "Search")
            .onChange(of: searchText) { newValue in
                print(newValue)
                if newValue.isEmpty {
                    print("Empty")
                    filteredMarkets = allMarkets
                }
                
                let filteredData = allMarkets.filter {
                    return $0.koreanName.localizedStandardContains(searchText) || $0.englishName.localizedStandardContains(searchText) || $0.market.localizedStandardContains(searchText)
                }
                filteredMarkets = filteredData
                
            }
            .refreshable {
                do {
                    print("refreshing")
                    allMarkets = try await UpbitAPI.fetchMarket()
                } catch {
                    print("error: \(error.localizedDescription)")
                }
            }
            .navigationTitle("SearchView")
        }
    }
}

struct RowView: View {
    let bitCoinImages = [
        "bitcoinsign",
        "bitcoinsign.circle",
        "bitcoinsign.circle.fill",
        "bitcoinsign.square",
        "bitcoinsign.square.fill"
    ]
    @Binding var market: Market
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: bitCoinImages.randomElement() ?? "bitcoinsign")
                .foregroundStyle(Color.random())
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
            
            Button {
                market.like.toggle()
            } label: {
                Image(systemName: "star")
                    .padding(.init(top: 10, leading: 10, bottom: 10, trailing: 0))
            }
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
    }
}

#Preview {
    CoinView()
}

