//
//  UserDefaults+Data.swift
//  Day7Assignments
//
//  Created by user on 5/22/24.
//

import Foundation

extension UserDefaults {
    func saveData<T>(_ data: T, with type: KeyType, completion: () -> ()) {
        UserDefaults.standard.setValue(data, forKey: type.forKey)
        completion()
    }
    
    // 저장할 변수들의 struct를 만들어두고 해당 struct로 변환하면 되려나...?
    func loadData<T>(_ type: KeyType, into: T.Type) -> T? {
        guard let data = UserDefaults.standard.data(forKey: type.forKey) as? T else { return nil }
        return data
    }
}
