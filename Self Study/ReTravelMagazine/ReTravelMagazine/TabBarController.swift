//
//  TabBarController.swift
//  ReTravelMagazine
//
//  Created by user on 6/1/24.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewControllers(addTabBarItem(), animated: true)
        tabBar.backgroundColor = .systemGray4
    }
    
    private func addTabBarItem() -> [UINavigationController] {
        var navigationItems: [UINavigationController] = []
        TabBarItemType.allCases.forEach { item in
            let vc = item.viewController
            vc.tabBarItem.title = item.title
            vc.tabBarItem.image = UIImage(systemName: item.imageName)
            vc.navigationItem.title = item.navigationTitle
            let nav = UINavigationController(rootViewController: vc)
            navigationItems.append(nav)
        }
        
        return navigationItems
    }
}


enum TabBarItemType: CaseIterable {
    static var allCases: [TabBarItemType] = [
        .magazine,
        .restaurant,
        .travel,
        .talk
    ]
    
    case magazine
    case restaurant
    case travel
    case talk
    
    var imageName: String {
        switch self {
        case .magazine:
            return "newspaper.fill"
        case .restaurant:
            return "fork.knife"
        case .travel:
            return "airplane.departure"
        case .talk:
            return "message"
        }
    }
    
    var title: String {
        switch self {
        case .magazine:
            return "Magazine"
        case .restaurant:
            return "Restaurant"
        case .travel:
            return "Travel"
        case .talk:
            return "Talk"
        }
    }
    
    var navigationTitle: String {
        return "SeSAC" + self.title
    }
    
    var viewController: UIViewController {
        switch self {
        case .magazine:
            return MagazineViewController()
        case .restaurant:
            return RestaurantViewController()
        case .travel:
            return TravelViewController()
        case .talk:
            return TalkViewController()
        }
    }
}
