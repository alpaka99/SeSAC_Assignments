//
//  TabBarController.swift
//  TamagotchiProject
//
//  Created by user on 6/7/24.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = HomeViewController()
        let nav1 = UINavigationController(rootViewController: vc1)
        
        
        setViewControllers([nav1], animated: true)
    }
}
