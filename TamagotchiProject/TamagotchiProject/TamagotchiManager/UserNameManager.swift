//
//  NavigationTitleManager.swift
//  TamagotchiProject
//
//  Created by user on 6/9/24.
//

import Foundation

final class UserNameManager {
    static var shared: UserNameManager = UserNameManager()
    private(set) var userNameInfo: UserNameInfo = UserNameInfo(userName: "익명") {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name("UserName"), object: nil)
        }
    }
    
    var userName: String {
        return userNameInfo.userName
    }
    
    
    private init() {
        loadData()
    }
    
    internal func initialze() {
        print("UserNameManager.shared initialize")
    }
    
    internal func setUserNameInfo(_ title: String) {
        userNameInfo = UserNameInfo(userName: title)
        saveData()
    }
    
    private func loadData() {
        if let loadedData = UserDefaults.standard.loadData(UserNameInfo.self) {
            userNameInfo = loadedData
        } else {
            userNameInfo = UserNameInfo(userName: "익명")
        }
    }
    
    private func saveData() {
        UserDefaults.standard.saveData(userNameInfo)
        loadData()
    }
    
    internal func resetData() {
        setUserNameInfo("익명")
        loadData()
    }
}


struct UserNameInfo: Codable {
    let userName: String
}
