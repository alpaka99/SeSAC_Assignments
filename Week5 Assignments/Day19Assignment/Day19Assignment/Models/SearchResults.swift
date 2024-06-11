//
//  SearchResults.swift
//  Day19Assignment
//
//  Created by user on 6/11/24.
//

struct SearchResult: Codable {
    let page: Int
    let results: [SearchData]
    let total_pages: Int
    let total_results: Int
}

struct SearchData: Codable {
    let title: String
    let overview: String
    let id: Int
    let backdrop_path: String?
    let poster_path: String?
}
