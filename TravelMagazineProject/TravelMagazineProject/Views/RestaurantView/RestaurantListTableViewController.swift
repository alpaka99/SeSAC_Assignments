//
//  RestaurantListTableViewController.swift
//  TravelMagazineProject
//
//  Created by user on 5/26/24.
//

import UIKit

final class RestaurantViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    static var cellState: CellState = CellState(states: [])
//    static var preloadedImages: [UIImage?] = []
    
    private let searchBar: UISearchBar = UISearchBar()
    private let tableView: UITableView = UITableView()
    
    private let restaurantList: RestaurantList = RestaurantList()
    
    
    
    override func loadView() {
        super.loadView()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(searchBar)
        self.view.addSubview(tableView)
        
        // configure searchBar
        configureSearchBar()
        
        // configure tableView
        configureTableView()

        // configure navigation controllers
        configureNavigationController()
        
        // configure tableview cells
        configureCells()
        
        // configure data
        // move to app delegate for image cache
    }
    
    private func configureSearchBar() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8),
        ])
    }
    
    private func configureTableView() {
        print(#function)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 8),
        ])
    }
    
    private func configureNavigationController() {
        navigationItem.title = "SeSAC Restaurants"
    }
    
    private func configureCells() {
        self.tableView.register(RestaurantTableViewCell.self, forCellReuseIdentifier: RestaurantTableViewCell.getReuseIdentifier())
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BasicCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantList.restaurantArray.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
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
