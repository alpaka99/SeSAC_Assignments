//
//  UserDefaults+Extension.swift
//  TamagotchiProject
//
//  Created by user on 6/9/24.
//

import Foundation

extension UserDefaults {
    internal func loadData<T: Codable>(_ type: T.Type) -> T? {
        let key = String(describing: T.self)
        if let loadedData = UserDefaults.standard.value(forKey: String(describing: T.self)) as? Data,
           let decodedData = try? JSONDecoder().decode(type, from: loadedData){
                return decodedData
            }
        return nil
    }
    
    internal func saveData<T: Codable>(_ data: T) {
        let encodedData = try? JSONEncoder().encode(data)
        let key = String(describing: T.self)
        UserDefaults.standard.setValue(encodedData, forKey: String(describing: T.self))
    }
}
