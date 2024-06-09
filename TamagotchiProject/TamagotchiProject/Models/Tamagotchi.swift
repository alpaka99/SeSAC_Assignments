//
//  Tamagotchi.swift
//  TamagotchiProject
//
//  Created by user on 6/8/24.
//
import Foundation

internal struct Tamagotchi: Codable, Identifiable, Equatable {
    static let dummyTamagotchi: Tamagotchi = Tamagotchi(name: "준비중이에요", imageNumber: 0, description: "아직 준비중인 다마고치에요")
    static let initialData: [Tamagotchi] = [
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
    
    private(set) var id: UUID = UUID()
    var name: String
    var imageNumber: Int
    var description: String
    var food: Int = 0
    var water: Int = 0
    
    
    internal var level: Int {
        get {
            let exp = Int((Double(food) / 5.0) + (Double(water) / 2.0)) / 10
            
            switch exp {
            case ..<1:
                return 1
            case 1..<10:
                return exp
            default:
                return 10
            }
        }
    }
    
    internal var imageName: String {
        switch level {
        case 10...:
            return "\(imageNumber)-\(level-1)"
        default:
            return "\(imageNumber)-\(level)"
        }
    }
    
    internal var status: String {
        return "LV\(level) • 밥알 \(food)개 • 물방울 \(water)개"
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
    
    static func == (lhs: Tamagotchi, rhs: Tamagotchi) -> Bool {
        return lhs.id == rhs.id
    }
}
