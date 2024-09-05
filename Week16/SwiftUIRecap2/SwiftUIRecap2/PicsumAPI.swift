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
    
    func requestPicsumData(of iteration: Int) async throws -> [Data] {
        try await withThrowingTaskGroup(of: Data.self) { taskGroup in
            var dataGroup = [Data]()
            for _ in 0..<iteration {
                
                
                taskGroup.addTask {
                    let url = URL(string: "https://picsum.photos/200/300")!
                        let (data, response) = try await URLSession.shared.data(from: url)
                        
                        return data
                }
                
                for try await data in taskGroup {
                    dataGroup.append(data)
                }
            }
            return dataGroup
        }
    }
}
