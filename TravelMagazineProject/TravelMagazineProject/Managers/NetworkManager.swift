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
    static let shared: DataManager = DataManager()
    
    internal func fetchImage(_ url: URL, completion: @escaping (UIImage) -> ())  {
        DispatchQueue.global(qos: .userInteractive).async { // fetch image asynchronously with kingfisermanager
            KingfisherManager.shared.retrieveImage(with: url) { result in
                switch result {
                case .success(let responseImage):
                    let resultImage = responseImage.image.withRenderingMode(.alwaysOriginal)
                    DispatchQueue.main.async { // update image in outer closure
                        completion(resultImage)
                    }
                case .failure(let error):
                    print("KingFisherError: \(error.localizedDescription)")
                }
            }
        }
    }
    
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
