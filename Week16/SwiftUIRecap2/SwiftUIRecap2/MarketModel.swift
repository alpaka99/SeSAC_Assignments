//
//  MarketModel.swift
//  SwiftUIRecap2
//
//  Created by user on 9/4/24.
//

import Foundation

typealias Markets = [Market]

struct Market: Hashable, Codable, Identifiable {
    let id = UUID()
    let market, koreanName, englishName: String

    enum CodingKeys: String, CodingKey {
        case market
        case koreanName = "korean_name"
        case englishName = "english_name"
    }
}


