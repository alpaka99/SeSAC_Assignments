//
//  TabBarController.swift
//  RxBasicButtonViewController
//
//  Created by user on 7/31/24.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nav1 = UINavigationController(rootViewController: SimplePickerViewController())
        nav1.tabBarItem.image = UIImage(systemName: "star.fill")
        
        let nav2 = UINavigationController(rootViewController: SimpleTableViewController())
        nav2.tabBarItem.image = UIImage(systemName: "heart.fill")
        
        let nav3 = UINavigationController(rootViewController: AddingNumbersViewController())
        nav3.tabBarItem.image = UIImage(systemName: "plus.viewfinder")
        
        setViewControllers([nav1, nav2, nav3], animated: true)
    }
}
