//
//  RestaurantListTableViewController.swift
//  TravelMagazineProject
//
//  Created by user on 5/26/24.
//

import UIKit

final class RestaurantListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView: UITableView = UITableView()
    
    private var restaurants: [Restaurant] = RestaurantList().restaurantArray
    private var filteredRestaurants: [Restaurant] = []
    
    weak var delegate: RestaurantListDelegate?
    
    
    override func loadView() {
        super.loadView()
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        layoutComponents()
        setComponentsUI()
        
        registerCells()
        
        // configure data
        fetchRestaurantListFromDelegate()
        
        // move to app delegate for image cache
    }
    
    private func layoutComponents() {
        self.view.addSubview(tableView)
        
        layoutTableView()
    }
    
    private func setComponentsUI() {
        setNavigationItemUI(.restaurant)
    }
    
    private func registerCells() {
        tableView.register(RestaurantTableViewCell.self, forCellReuseIdentifier: RestaurantTableViewCell.reuseIdentifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
    }


    private func layoutTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -16),
        ])
    }
    
    private func setNavigationItemUI(_ type: NavigationItemType) {
        navigationItem.title = type.title
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantTableViewCell.reuseIdentifier, for: indexPath) as? RestaurantTableViewCell {

            let data = filteredRestaurants[indexPath.row]
            
            cell.configureCellData(data)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath) as UITableViewCell
            
            cell.textLabel?.text = BasicCellInfo.text
            
            return cell
        }
    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = filteredRestaurants[indexPath.row]
        delegate?.moveToAnnotation(for: data)
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {[weak self] _,_,_ in
            self?.showDeleteAlert(for: indexPath.row)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
    private func showDeleteAlert(for index: Int) {
        let alertController = UIAlertController()
        alertController.title = AlertType.restaurantDelete.title
        alertController.message = AlertType.restaurantDelete.message
        
        let deleteButton = UIAlertAction(title: AlertActionType.delete.title, style: .destructive) { [weak self] _ in
        self?.deleteItem(at: index)
    }
        
        let cancelButton = UIAlertAction(title: AlertActionType.cancel.title, style: AlertActionType.cancel.style)
        
        alertController.addAction(deleteButton)
        alertController.addAction(cancelButton)
        
        present(alertController, animated: true)
    }
    
    private func deleteItem(at index: Int) {
        restaurants.remove(at: index)
        filteredRestaurants = restaurants
        tableView.reloadData()
        
    }
    
    internal func fetchRestaurantListFromDelegate() {
        if let fetchedRestaurantList = delegate?.fetchFilteredList() {
            filteredRestaurants = fetchedRestaurantList
            tableView.reloadData()
        }
    }
}


