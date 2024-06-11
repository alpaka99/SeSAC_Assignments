//
//  SearchManager.swift
//  Day19Assignment
//
//  Created by user on 6/11/24.
//


import UIKit

import Alamofire
import Kingfisher

final class SearchManager {
    static var shared: SearchManager = SearchManager()
    
    let url: String = "https://api.themoviedb.org/3/search/movie"
    private(set) var page: Int = 1
    
    
    // MARK: 나중에 cache 형태로 변경
    // String : ResultType(ResponseType)
    private(set) var searchResult: [String] = []
    
    internal func initialize() {
        print("SearchManager Initialzing")
        searchData("spiderman")
    }
    
    internal func searchData(_ text: String) {
        var parameters: Parameters = [
            "query" : "",
            "include_adults" : "false",
            "language" : "en-US",
            "page" : "1"
        ]
        
        parameters["query"] = text
        parameters["page"] = page
        
        let headers: HTTPHeaders = TMDBAPIKey.headers
        
        AF.request(
            url,
            parameters: parameters,
            headers: headers
        )
        .responseDecodable(of: SearchResult.self) { response in
            switch response.result {
            case .success(let value):
                dump(value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    internal func fetchImage(_ imageUrl: String, completionHandler: @escaping (UIImage?)->()) {
        let url = "https://image.tmdb.org/t/p/original\(imageUrl)"
        
        if let url = URL(string: url) {
            KingfisherManager.shared.retrieveImage(
                with: url) { result in
                    switch result {
                    case .success(let value):
                        completionHandler(value.image)
                    case .failure(let error):
                        print(error)
                        completionHandler(UIImage(systemName: ""))
                    }
                }
        }
    }
}


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
}
