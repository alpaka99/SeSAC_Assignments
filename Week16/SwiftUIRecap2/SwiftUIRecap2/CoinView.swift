//
//  LastView.swift
//  SwiftUIRecap2
//
//  Created by user on 9/3/24.
//
import SwiftUI


import SwiftUI

struct CoinView: View {
    @State private var markets: Markets = []
    @State private var banner = Banner()
    
    var body: some View {
        NavigationView {
            ScrollView {
                bannerView()
                
                listView()
            }
            .refreshable {
                markets.shuffle()
            }
            .navigationTitle("CoinView")
        }
        .task {
            do {
                let result = try await UpbitAPI.fetchMarket()
                markets = result
            } catch {
                print("Market Fetch Error: \(error.localizedDescription)")
            }
        }
    }
    
    // onAppear는 기본적으로 동기 환경에서 실행되므로, 비동기 작업을 처리하려면 추가적인 래핑이 필요(e.g DispatchQueue.global.async)
    // 반면에 task는 기본적으로 비동기 환경이기때문에 이런 래핑 처리가 필요 없음
    
    func listView() -> some View {
        return LazyVStack {
            ForEach($markets) { $market in
                rowView(market: $market)
            }
        }
    }
    
    func bannerView() -> some View {
        return RoundedRectangle(cornerRadius: 12)
            .fill(banner.color)
            .frame(height: 150)
            .frame(maxWidth: .infinity)
            .padding()
            .overlay(alignment: .leading) {
                Circle()
                    .fill(.white.opacity(0.3))
                    .scaleEffect(2)
            }
            
            .overlay(alignment: .bottomLeading) {
                VStack(alignment: .leading, spacing: 16) {
                    Text(markets.randomElement()?.koreanName ?? "")
                        .font(.callout)
                    Text(markets.randomElement()?.englishName ?? "")
                        .font(.title)
                        .bold()
                }
                .foregroundStyle(.white)
                .padding(20)
            }
    }
}

#Preview {
    CoinView()
}


struct Banner: Hashable, Identifiable {
    let id = UUID()
    var total = Int.random(in: 1000...5000) * 150
    let color = Color.random()
    
    var totalFormat: String {
        return String(total.formatted()) + "원"
    }
}


extension Color {
    static func random() -> Color {
        return Color.init(
            red: Double.random(in: 0...1),
            green: Double.random(in: 0...1),
            blue: Double.random(in: 0...1)
        )
    }
}

struct rowView: View {
    @Binding var market: Market
    
    var body: some View {
        
        HStack {
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
            
            Button {
                market.like.toggle()
            } label: {
                Image(systemName: market.like ? "star.fill" : "star")
            }
        }
    }
}
