//
//  CreditResponse.swift
//  Day18Assignment
//
//  Created by user on 6/11/24.
//

struct CreditResponse: Codable {
    let cast: [CreditInfo]
}

struct CreditInfo: Codable {
    let adult: Bool
    let gender: Int
    let id: Int
    let known_for_department: String
    let name: String
    let original_name: String
    let popularity: Double
    let profile_path: String
    let character: String
    let credit_id: String
    let order: Int
}
