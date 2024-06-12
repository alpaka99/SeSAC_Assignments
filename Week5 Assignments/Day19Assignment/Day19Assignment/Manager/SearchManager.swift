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
    
    private(set) var page: Int = 1
    private var totalPage: Int = 1
    
    
    // MARK: 나중에 cache 형태로 변경
    // String : ResultType(ResponseType)
    private(set) var searchResult: [SearchData] = [] {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name("SearchResult"), object: nil)
        }
    }
    
    internal func initialize() {
        print("SearchManager Initialzing")
    }
    
    internal func searchData(_ text: String) {
        if page <= totalPage {
            let url: String = "https://api.themoviedb.org/3/search/movie"
            
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
            .responseDecodable(of: SearchResult.self) {[weak self] response in
                switch response.result {
                case .success(let value):
                    //                dump(value)
                    if value.page == 1 {
                        self?.totalPage = value.total_pages
                        self?.searchResult = value.results
                    } else {
                        self?.searchResult.append(contentsOf: value.results)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
//    internal func fetchImageById(id: Int, completionHandler: @escaping(String?)->()) {
//        let fetchImageByIdUrl = "https://api.themoviedb.org/3/movie/\(id)/images"
//        
//        let headers: HTTPHeaders = TMDBAPIKey.headers
//        
//        AF.request(
//            fetchImageByIdUrl,
//            headers: headers
//        )
//        .responseDecodable(of: ImagePathResult.self) { response in
//            switch response.result {
//            case .success(let value):
//                if !value.posters.isEmpty, let item = value.posters.first {
//                    completionHandler(item.file_path)
//                } else if !value.posters.isEmpty, let item = value.backdrops.first {
//                    completionHandler(item.file_path)
//                } else if !value.logos.isEmpty, let item = value.logos.first {
//                    completionHandler(item.file_path)
//                } else {
//                    completionHandler(nil)
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
    internal func fetchImage(_ imageUrl: String, completionHandler: @escaping (UIImage?)->()) {
        let imageURL = "https://image.tmdb.org/t/p/original\(imageUrl)"
        
        if let url = URL(string: imageURL) {
            KingfisherManager.shared.retrieveImage(with: url) { result in
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
    
    internal func searchNewData(_ text: String) {
        resetPage()
        searchData(text)
    }
    
    internal func prefetchData(_ text: String) {
        incrementPage()
        searchData(text)
    }
    
    private func incrementPage() {
        self.page += 1
    }
    
    internal func resetPage() {
        self.page = 1
        self.searchResult = []
    }
}


struct ImagePathResult: Decodable {
    let backdrops: [ImagePathData]
    let logos: [ImagePathData]
    let posters: [ImagePathData]
}

struct ImagePathData: Decodable {
    let file_path: String
}
