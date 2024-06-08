//
//  Tamagotchi.swift
//  TamagotchiProject
//
//  Created by user on 6/8/24.
//


internal struct Tamagotchi {
    var name: String
    var imageNumber: Int
    var description: String
    var food: Int = 0
    var water: Int = 0
    
    
    internal var level: Int {
        get {
            let exp = Int((Double(food) / 5.0) + (Double(water) / 2.0)) / 10
            
            switch exp {
//            case ..<1:
//                return 1
//            case 1..<10:
//                return exp
            default:
                return 9
            }
        }
    }
    
    internal var imageName: String {
        return "\(imageNumber)-\(level)"
    }
    
    internal mutating func addFood(_ amount: Int) {
        self.food += amount
    }
    
    internal mutating func addWater(_ amount: Int) {
        self.water += amount
    }
    
    internal mutating func changeName(_ name: String) {
        self.name = name
    }
}


internal struct TamagotchiData {
    let tamagotchis: [Tamagotchi] = [
        Tamagotchi(
            name: "따끔따끔 다마고치",
            imageNumber: 1,
            description: "따끔"
        ),
        Tamagotchi(
            name: "방실방실 다마고치",
            imageNumber: 2,
            description: "방실"
        ),
        Tamagotchi(
            name: "반짝반짝 다마고치",
            imageNumber: 3,
            description: "반짝"
        ),
    ]
}
