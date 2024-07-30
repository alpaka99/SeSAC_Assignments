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
        
        
        setViewControllers([nav1], animated: true)
    }
}
