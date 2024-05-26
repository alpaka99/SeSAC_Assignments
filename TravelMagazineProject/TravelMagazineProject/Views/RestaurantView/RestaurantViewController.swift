//
//  RestaurantViewController.swift
//  TravelMagazineProject
//
//  Created by user on 5/26/24.
//

import UIKit

class RestaurantViewController: UIViewController {
    let restaurantListViewController = RestaurantListTableViewController()
    
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
