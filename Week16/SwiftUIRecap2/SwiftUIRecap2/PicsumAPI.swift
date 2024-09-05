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
    
    func requestPicsumData(of iteration: Int) async throws -> [ImageData] {
        try await withThrowingTaskGroup(of: Data.self) { taskGroup in
            var imaggeDataGroup = [ImageData]()
            for _ in 0..<iteration {
                
                
                taskGroup.addTask {
                    let url = URL(string: "https://picsum.photos/200/300")!
                        let (data, _) = try await URLSession.shared.data(from: url)
                        
                        return data
                }
                
                for try await data in taskGroup {
                    let imageData = ImageData(data: data, title: "이미지: \(Int.random(in: 1...100))")
                    imaggeDataGroup.append(imageData)
                }
            }
            return imaggeDataGroup
        }
    }
}
