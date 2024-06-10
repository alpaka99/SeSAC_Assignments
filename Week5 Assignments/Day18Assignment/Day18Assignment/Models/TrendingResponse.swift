//
//  TrendingResponse.swift
//  Day18Assignment
//
//  Created by user on 6/11/24.
//

struct TrendingResponse: Codable {
    let page : Int
    let results : [TrendingInfo]
}

struct TrendingInfo: Codable {
    let backdrop_path: String
    let id: Int
    let original_name : String // error
    let overview : String
    let poster_path : String
    let media_type : String
    let adult : Bool
    let name : String // error
    let original_language : String
    let genre_ids : [Int]
    let popularity : Double
    let first_air_date : String // error
    let vote_average : Double
    let vote_count : Int
    let origin_country : [String] // error
}

