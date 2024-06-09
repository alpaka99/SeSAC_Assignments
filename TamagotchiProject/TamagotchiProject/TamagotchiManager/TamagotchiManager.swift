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
            NotificationCenter.default.post(name: NSNotification.Name("TamagotchiData"), object: nil)
        }
    }
    
    // 값을 복사해서 가져오는게 아니라 주소값을 가져오는 방법은 없을까?
    internal private(set) var selectedTamagotchi: Tamagotchi = Tamagotchi.dummyTamagotchi {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name("SelectedTamagotchi"), object: nil)
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
        } else {
            // if nil, load tamagotchi data from mode
            tamagotchiData = Tamagotchi.initialData
        }
    }
    
    private func saveTamagotchiData() {
        //save tamagotchi data
        UserDefaults.standard.saveData(tamagotchiData)
    }
    
    internal func setSelectedTamagotchi(with tamagotchi: Tamagotchi) {
        self.selectedTamagotchi = tamagotchi
        applySelectedTamagotchiChange()
    }
    
    private func applySelectedTamagotchiChange() {
        if let index = fetchTargetTamagotchiIndex(selectedTamagotchi.id) {
            tamagotchiData[index] = selectedTamagotchi
            saveTamagotchi()
        }
    }
    
    private func fetchTargetTamagotchiIndex(_ id: UUID) -> Int? {
        for index in 0..<tamagotchiData.count {
            if tamagotchiData[index].id == id {
                return index
            }
        }
        return nil
    }
    
    //MARK: 메서드 이름 변경하기
    internal func saveTamagotchi() {
        saveTamagotchiData()
        loadTamagotchiData()
    }
    
    internal func feedTamagotchi(_ tamagotchi: Tamagotchi, type: TGButtonTextFieldType, amount: Int = 1) {
        if let index = fetchTargetTamagotchiIndex(tamagotchi.id) {
            if amount < type.limit {
                var tamagotchi = tamagotchiData[index]
                switch type {
                case .food:
                    tamagotchi.addFood(amount)
                case .water:
                    tamagotchi.addWater(amount)
                }
                setSelectedTamagotchi(with: tamagotchi)
            }
        }
    }
    
    internal func resetData(completion: ()->()) {
        tamagotchiData = Tamagotchi.initialData
        saveTamagotchi()
        completion()
    }
}

