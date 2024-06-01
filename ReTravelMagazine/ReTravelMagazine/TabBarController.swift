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
        
        let magazineVC = MagazineViewController()
        let restaurantVC = RestaurantViewController()
        let travelVC = TravelViewController()
        let talkVC = TalkViewController()
        
        
        magazineVC.tabBarItem.image = UIImage(systemName: "number")
        magazineVC.tabBarItem.title = "Magazine"
        restaurantVC.tabBarItem.image = UIImage(systemName: "number")
        restaurantVC.tabBarItem.title = "Restaurant"
        travelVC.tabBarItem.image = UIImage(systemName: "number")
        travelVC.tabBarItem.title = "Travel"
        talkVC.tabBarItem.image = UIImage(systemName: "number")
        talkVC.tabBarItem.title = "Talk"
        
        let magazineNav = UINavigationController(rootViewController: magazineVC)
        let restaurantNav = UINavigationController(rootViewController: restaurantVC)
        let travelNav = UINavigationController(rootViewController: travelVC)
        let talkNav = UINavigationController(rootViewController: talkVC)
        
        self.setViewControllers([magazineNav, restaurantNav, travelNav, talkNav], animated: true)
        
        tabBar.backgroundColor = .systemGray4
    }
}
