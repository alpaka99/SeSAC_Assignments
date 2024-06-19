//
//  TabBarController.swift
//  day24 Assignment
//
//  Created by user on 6/19/24.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let restaurantViewController = RestaurantViewController()
        let restaurantNavigationController = UINavigationController(rootViewController: restaurantViewController)
        restaurantNavigationController.tabBarItem.image = UIImage(systemName: TabBarItem.restaurant.systemName)
        restaurantNavigationController.tabBarItem.title = TabBarItem.restaurant.title
        
        let weatherCheckViewController = WeatherCheckViewController()
        let weatherCheckNavigationController = UINavigationController(rootViewController: weatherCheckViewController)
        weatherCheckViewController.tabBarItem.image = UIImage(systemName: TabBarItem.weatherCheck.systemName)
        weatherCheckNavigationController.tabBarItem.title = TabBarItem.weatherCheck.title
        
        setViewControllers(
            [
                weatherCheckNavigationController,
                restaurantNavigationController,
            ],
            animated: true
        )
    }
}

enum TabBarItem {
    case restaurant
    case weatherCheck
    
    var title: String {
        switch self {
        case .restaurant:
            return "식당"
        case .weatherCheck:
            return "날씨"
        }
    }
    
    var systemName: String {
        switch self {
        case .restaurant:
            return ImageName.restaurantTabImage
        case .weatherCheck:
            return ImageName.weatherCheckTabImage
        }
    }
}
