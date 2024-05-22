//
//  UserDefaults+Data.swift
//  Day7Assignments
//
//  Created by user on 5/22/24.
//

import Foundation

extension UserDefaults {
    func saveData<T: Codable>(
        _ data: T,
        with type: KeyType,
        completion: (Result<Bool, UserDefaultErrorType>) -> ()
    ) {
        var jsonData: Data
        do {
            jsonData = try JSONEncoder().encode(data)
            UserDefaults.standard.setValue(jsonData, forKey: type.forKey)
            completion(.success(true))
        } catch {
            completion(.failure(.convertFailure))
        }
    }
    
    // 저장할 변수들의 struct를 만들어두고 해당 struct로 변환하면 되려나...? -> 이렇게 함. 대신에 struct 혹은 class는 UserDefaults에 넣으려면 json으로 바꿔야함.
    func loadData<T: Codable>(
        _ key: KeyType,
        into type: T.Type,
        completion: (Result<T, UserDefaultErrorType>) -> ()
    ) {
        
        guard let jsonData = UserDefaults.standard.data(forKey: key.forKey) else {
            return completion(.failure(.convertFailure))
        }
        
        guard let data = try? JSONDecoder().decode(type, from: jsonData) else { return }
        return completion(.success(data))
    }
}
