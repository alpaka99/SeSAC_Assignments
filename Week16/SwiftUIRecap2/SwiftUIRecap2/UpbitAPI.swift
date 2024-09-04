//
//  UpbitAPI.swift
//  SwiftUIRecap2
//
//  Created by user on 9/4/24.
//

import Foundation

struct UpbitAPI {
    
    private init() { }

    static func fetchAllMarket(completion: @escaping (Markets) -> Void) {
        
        let url = URL(string: "https://api.upbit.com/v1/market/all")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let decodedData = try JSONDecoder().decode(Markets.self, from: data)
                DispatchQueue.main.async {
                    completion(decodedData)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
    static func fetchMarket() async throws -> Markets { // 비동기 작업의 결과를 completionHandler가 아닌 return 값으로 받을 수 있게 함
        let url = URL(string: "https://api.upbit.com/v1/market/all")!
        
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        let decodedData = try JSONDecoder().decode(Markets.self, from: data)
        
        return decodedData
    }
}


