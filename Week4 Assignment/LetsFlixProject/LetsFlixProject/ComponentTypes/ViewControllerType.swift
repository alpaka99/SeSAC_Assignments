//
//  ViewControllerType.swift
//  LetsFlixProject
//
//  Created by user on 6/4/24.
//

import UIKit

enum ViewControllerType: CaseIterable {
    static let type = UIViewController.self
    
    static let allCases: [ViewControllerType] = [
        .home("홈"),
        .new,
        .saved
    ]
    
    case home(String)
    case new
    case saved
    
    var title: String {
        switch self {
        case .home(let title):
            return title
        case .new:
            return "New & Hot"
        case .saved:
            return "저장한 콘텐츠 목록"
        }
    }
    
    var viewController: UIViewController {
        switch self {
        case .home(_):
            return HomeViewController()
        case .new:
            return UIViewController()
        case .saved:
            return UIViewController()
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .home(_):
            return .darkGray
        case .new, .saved:
            return .white
        }
    }
    
    var systemName: String {
        switch self {
        case .home(_):
            return "house.fill"
        case .new:
            return "play.rectangle.on.rectangle"
        case .saved:
            return "arrow.down.circle"
        }
    }
    
    func buildViewController() -> UIViewController {
        let vc = self.viewController
        vc.title = title
        vc.view.backgroundColor = self.backgroundColor
        
        return vc
    }
    
    func build() -> UINavigationController {
        let nav = UINavigationController(rootViewController: self.buildViewController())
        
        nav.tabBarItem.title = self.title
        nav.tabBarItem.image = UIImage(systemName: self.systemName)
        
        return nav
    }
}
