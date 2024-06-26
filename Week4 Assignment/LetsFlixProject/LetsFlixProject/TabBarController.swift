//
//  TabBarController.swift
//  LetsFlixProject
//
//  Created by user on 6/4/24.
//

import UIKit

final class TabBarController: UITabBarController {
    lazy var tabs = buildTabs()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().backgroundColor = .darkGray.withAlphaComponent(0.7)
        UITabBar.appearance().tintColor = .white
        
        
        setViewControllers(tabs, animated: true)
    }
    
    private func buildTabs() -> [UINavigationController] {
        var navs: [UINavigationController] = []
        
        ViewControllerType.allCases.forEach { type in
            navs.append(type.build())
        }
        
        return navs
    }
}
