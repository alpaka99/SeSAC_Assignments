//
//  UserDefaults+Data.swift
//  TravelMagazineProject
//
//  Created by user on 5/26/24.
//

import Foundation

extension UserDefaults {
    func saveData<T: UserDefaultable>(_ data: T) {
        if let value = try? JSONEncoder().encode(data) {
            UserDefaults.standard.setValue(value, forKey: T.getUserDefaultKey())
        }
    }
    
    func loadData<T: UserDefaultable>(_: T.Type) -> T? {
        if let jsonData = UserDefaults.standard.data(forKey: T.getUserDefaultKey()) {
            if let data = try? JSONDecoder().decode(T.self, from: jsonData) {
                return data
            }
        }
        return nil
    }
}
