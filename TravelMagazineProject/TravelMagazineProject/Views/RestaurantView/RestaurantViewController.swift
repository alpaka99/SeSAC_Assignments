//
//  RestaurantViewController.swift
//  TravelMagazineProject
//
//  Created by user on 5/26/24.
//

import UIKit

final class RestaurantViewController: UIViewController {
    private let restaurantListViewController = RestaurantListTableViewController()
    
    override func loadView() {
        self.view = UIView()
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "SeSAC Restaurant"
        
        
        self.addChild(restaurantListViewController)
    }
    

}
