//
//  TamagotchiManager.swift
//  TamagotchiProject
//
//  Created by user on 6/9/24.
//

import Foundation

final class TamagotchiManager {
    internal static var shared: TamagotchiManager = TamagotchiManager()
    internal private(set) var tamagotchiData: [Tamagotchi] = []
    
    // 값을 복사해서 가져오는게 아니라 주소값을 가져오는 방법은 없을까?
    internal private(set) var selectedTamagotchi: Tamagotchi = Tamagotchi.dummyTamagotchi
    
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
    }
    
    internal func saveTamagotchi() {
        saveTamagotchiData()
        loadTamagotchiData()
    }
}

