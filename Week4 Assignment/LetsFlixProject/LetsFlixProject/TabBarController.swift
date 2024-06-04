//
//  TabBarController.swift
//  LetsFlixProject
//
//  Created by user on 6/4/24.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setViewControllers(buildTabs(), animated: true)
    }
    
    private func buildTabs() -> [UINavigationController] {
        var navs: [UINavigationController] = []
        
        ViewControllerType.allCases.forEach { type in
            navs.append(type.build())
        }
        
        return navs
    }
}
