//
//  TamagotchiManager.swift
//  TamagotchiProject
//
//  Created by user on 6/9/24.
//

import Foundation

final class TamagotchiManager {
    internal static var shared: TamagotchiManager = TamagotchiManager()
    internal private(set) var tamagotchiData: [Tamagotchi] = [] {
        didSet {
            // use notification manager publish signal
//            NotificationCenter.default.post(name: <#T##NSNotification.Name#>, object: <#T##Any?#>, userInfo: <#T##[AnyHashable : Any]?#>)
        }
    }
    
    internal private(set) var selectedTamagotchi: Tamagotchi = Tamagotchi.dummyTamagotchi {
        didSet {
            // send notification
        }
    }
    
    private init() {
        loadTamagotchiData()
    }
    
    internal func initialize() {
        print("TamagotchiManager.shared initialzing")
    }
    
    private func loadTamagotchiData() {
//         load tamagotchi data from userdefault
        if let loadedData = UserDefaults.standard.loadData([Tamagotchi].self) {
            self.tamagotchiData = loadedData
            print(loadedData)
        } else {
            // if nil, load tamagotchi data from mode
            tamagotchiData = TamagotchiData().tamagotchis
        }
    }
    
    private func saveTamagotchiData() {
        //save tamagotchi data
        UserDefaults.standard.saveData(tamagotchiData)
    }
    
    internal func setSelectedTamagotchi(_ index: Int) {
        if index < tamagotchiData.count {
            self.selectedTamagotchi = tamagotchiData[index]
        }
        print(selectedTamagotchi)
    }
    
    internal func saveTamagotchi() {
        saveTamagotchiData()
        loadTamagotchiData()
    }
}

