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
        nav1.title = "Picker"
        
        let nav2 = UINavigationController(rootViewController: SimpleTableViewController())
        nav2.tabBarItem.image = UIImage(systemName: "heart.fill")
        nav2.title = "TableView"
        
        let nav3 = UINavigationController(rootViewController: AddingNumbersViewController())
        nav3.tabBarItem.image = UIImage(systemName: "plus.viewfinder")
        nav3.title = "AddNumber"
        
        let nav4 = UINavigationController(rootViewController: SimpleValidationViewController())
        nav4.tabBarItem.image = UIImage(systemName: "square.on.square.intersection.dashed")
        nav4.title = "Validate"
        
        setViewControllers([nav1, nav2, nav3, nav4], animated: true)
    }
}
