//
//  RestaurantListTableViewController.swift
//  TravelMagazineProject
//
//  Created by user on 5/26/24.
//

import UIKit

final class RestaurantViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    private let searchBar: UISearchBar = UISearchBar()
    private let tableView: UITableView = UITableView()
    
    private let restaurants: [Restaurant] = RestaurantList().restaurantArray
    private var filteredRestaurants: [Restaurant] = []
    
    
    
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
        filteredRestaurants = restaurants
        // move to app delegate for image cache
    }
    
    private func configureSearchBar() {
        searchBar.delegate = self
        
        layoutSearchBar()
        setSearchBarUI()
    }
    
    private func layoutSearchBar() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8),
        ])
    }
    
    private func setSearchBarUI() {
        
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        layoutTableView()
        setTableViewUI()
    }
    
    private func layoutTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 8),
        ])
    }
    
    private func setTableViewUI() {
        
    }
    
    private func configureNavigationController() {
        navigationItem.title = "SeSAC Restaurants"
    }
    
    private func configureCells() {
        self.tableView.register(RestaurantTableViewCell.self, forCellReuseIdentifier: RestaurantTableViewCell.getReuseIdentifier())
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BasicCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredRestaurants.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantTableViewCell.getReuseIdentifier(), for: indexPath) as? RestaurantTableViewCell {

            let data = filteredRestaurants[indexPath.row]
            
            cell.configureCellData(data)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as UITableViewCell
            
            cell.textLabel?.text = "Something went wrong... 😞"
            
            return cell
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty == false {
            filteredRestaurants = restaurants.filter { restaurant in
                return restaurant.name.localizedStandardContains(searchText) || restaurant.category.localizedStandardContains(searchText)
            }
        } else {
            filteredRestaurants = restaurants
        }
        
        tableView.reloadData()
    }
}
