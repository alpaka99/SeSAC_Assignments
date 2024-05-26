//
//  RestaurantListTableViewController.swift
//  TravelMagazineProject
//
//  Created by user on 5/26/24.
//

import UIKit

final class RestaurantListTableViewController: UITableViewController {
    static var cellState: CellState = CellState(states: [])
    static var preloadedImages: [UIImage?] = []
    
    
    private let restaurantList: RestaurantList = RestaurantList()
    
    private let searchView: UIView = RestaurantSearchView()

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // configure navigation controllers
        configureNavigationController()
        
        // configure tableview cells
        configureCells()
        
        // configure data
        // move to app delegate for image cache
    }
    
    private func configureNavigationController() {
        navigationItem.title = "SeSAC Restaurants"
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return searchView
    }
    
    private func configureCells() {
        self.tableView.register(RestaurantTableViewCell.self, forCellReuseIdentifier: RestaurantTableViewCell.getReuseIdentifier())
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BasicCell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantTableViewCell.getReuseIdentifier(), for: indexPath) as? RestaurantTableViewCell {

            let restaurantData = restaurantList.restaurantArray[indexPath.row]
            
            cell.nameLabel.text = restaurantData.name
            cell.categoryLabel.text = restaurantData.category
            cell.phoneNumberLabel.text = restaurantData.phoneNumber
            
            let url = URL(string: restaurantData.image)
            cell.restaurantImage.kf.setImage(with: url)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as UITableViewCell
            
            cell.textLabel?.text = "Something went wrong... 😞"
            
            return cell
        }
    }
}

protocol RestaurantListTableViewControllerDelegate {
    var delegate: RestaurantListTableViewController? { get }
    func favoriteChanged()
}
