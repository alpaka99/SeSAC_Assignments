//
//  PicsumAPI.swift
//  SwiftUIRecap2
//
//  Created by user on 9/5/24.
//

import Foundation

final class PicsumAPI {
    static let shared = PicsumAPI()
    private init() { }
    
    func requestPicsumData() async throws -> Data {
        let url = URL(string: "https://picsum.photos/200/300")!
        let (data, response) = try await URLSession.shared.data(from: url)
        
        return data
    }
}
