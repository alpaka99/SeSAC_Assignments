//
//  TabBarController.swift
//  Day3Assignment
//
//  Created by user on 5/16/24.
//

import UIKit

//MARK: TabBar를 코드로 넣으면 자꾸 IBOutlet쪽에서 없는 객체를 사용한다는 에러가 뜸. 왜지?
final class TabBarController: UITabBarController {
    
    var tabBarViewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = RandomPosterViewController()
        let vc2 = SearchViewController()
        let vc3 = SavedContentViewController()
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc3)
        let nav3 = UINavigationController(rootViewController: vc2)
        nav1.title = "vc1"
        nav2.title = "vc2"
        nav3.title = "vc3"
        
        setViewControllers([nav1, nav2, nav3], animated: false)
    }
    
    
    private func setTabBarItem() {
        let navigationControllers: [UINavigationController] = TabBarItemType.getNavigationControllers()
        print(navigationControllers)
        self.setViewControllers(
            navigationControllers, animated: false
        )
    }
    
}


fileprivate enum TabBarItemType: CaseIterable {
    case randomPosterViewController
    case searchViewController
    case savedContentViewController
    
    static func getNavigationControllers() -> [UINavigationController] {
        var navigationControllers: [UINavigationController] = []
        
        Self.allCases.forEach { tabBarItemType in
            let viewController = tabBarItemType.getViewController()
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.navigationItem.title = tabBarItemType.getNavigationControllerTitle()
            navigationController.tabBarItem.title = tabBarItemType.getTabBarItemTitle()
            navigationController.tabBarItem.image = UIImage(systemName: tabBarItemType.getTabBarImageName())
            navigationControllers.append(navigationController)
        }
        return navigationControllers
    }
    
    func getViewController() -> UIViewController {
        switch self {
        case .randomPosterViewController:
            return RandomPosterViewController()
        case .searchViewController:
            return SearchViewController()
        case .savedContentViewController:
            return SavedContentViewController()
        }
    }
    
    func getNavigationControllerTitle() -> String {
        switch self {
        case .randomPosterViewController:
            return "1"
        case .searchViewController:
            return "2"
        case .savedContentViewController:
            return "3"
        }
    }
    
    func getTabBarItemTitle() -> String {
        switch self {
        case .randomPosterViewController:
            return "홈"
        case .searchViewController:
            return "검색"
        case .savedContentViewController:
            return "더보기"
        }
    }
    
    
    func getTabBarImageName() -> String {
        switch self {
        case .randomPosterViewController:
            return "house.fill"
        case .searchViewController:
            return "play.rectangle.on.rectangle.fill"
        case .savedContentViewController:
            return "arrow.down.circle.fill"
        }
    }
}
