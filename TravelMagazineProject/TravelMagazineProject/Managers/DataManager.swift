//
//  NetworkManager.swift
//  TravelMagazineProject
//
//  Created by user on 5/27/24.
//

import Foundation
import Kingfisher
import UIKit

struct DataManager {
    // MARK: Kingfisher도 싱글톤으로 작동하는데 또 싱글톤인 NetworkManager를 사용하는게 맞을까..?
    // 이건 다시 비동기 처리를 안해도 될것 같음. Kingfisher 내부적으로 처리를 하는듯?
    static let shared: DataManager = DataManager()
    
    
    // 어짜피 kingfisher가 비동기 처리를 해주는데 여기서 datamanager로 굳이 감싸서 다시 처리하는게 맞나...?
    internal func fetchImage(_ url: URL, completion: @escaping (UIImage) -> ())  {
        KingfisherManager.shared.retrieveImage(with: url) { kingfisherResult in
            switch kingfisherResult {
            case .success(let successResult):
                completion(successResult.image)
            case .failure(let failResult):
                print("KingFisher RetrieveImage error: \(failResult.localizedDescription)")
            }
        }
    }
    
    // MARK: 이렇게 코드를 짜는것의 이점이 무엇일까에 대한 고민을 해보자(feat. UserDefaults는 thread safe하다 by 공식문서)
    // asynchronously complete user default sync process
    internal func syncData<T: UserDefaultable>(_ data: T, completion: @escaping(T?) -> ()) {
        DispatchQueue.global(qos: .userInitiated).async {
            UserDefaults.standard.saveData(data)
            let data = UserDefaults.standard.loadData(data)
            
            DispatchQueue.main.async {
                completion(data)
            }
        }
    }
}
