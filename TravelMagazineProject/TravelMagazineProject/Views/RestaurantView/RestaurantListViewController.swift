//
//  RestaurantListTableViewController.swift
//  TravelMagazineProject
//
//  Created by user on 5/26/24.
//

import UIKit

final class RestaurantListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    private let searchBar: UISearchBar = UISearchBar()
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
//        filteredRestaurants = restaurants
        fetchRestaurantListFromDelegate()
        
        // move to app delegate for image cache
    }
    
    private func layoutComponents() {
        self.view.addSubview(searchBar)
        self.view.addSubview(tableView)
        
        layoutSearchBar()
        layoutTableView()
    }
    
    private func setComponentsUI() {
        setNavigationItemUI(.restaurant)
    }
    
    private func registerCells() {
        tableView.register(RestaurantTableViewCell.self, forCellReuseIdentifier: RestaurantTableViewCell.reuseIdentifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
    }
    
    private func configureSearchBar() {
        layoutSearchBar()
    }
    
    private func layoutSearchBar() {
        searchBar.delegate = self
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 16),
            searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8),
        ])
    }
    
    private func layoutTableView() {
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
    
//    internal func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchText.isEmpty {
//            filteredRestaurants = restaurants
//        } else {
//            filteredRestaurants = restaurants.filter { restaurant in
//                return filterRestaurant(for: restaurant, with: searchText)
//            }
//        }
//        
//        tableView.reloadData()
//    }
    
//    
//    private func filterRestaurant(for restaurant: Restaurant, with searchText: String) -> Bool {
//        return restaurant.name.localizedCaseInsensitiveContains(searchText) || restaurant.category.localizedCaseInsensitiveContains(searchText)
//    }
    
    
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
        
        
        // MARK: action도 builder를 사용해서 만드는 방법 없을까? -> handler로 self의 method를 트리거하려면 delegate를 쓴다던가...?
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



// 프로토콜로 builder를 선언해놔서 boilerplate를 줄일 수 있을까...?
// 아 근데 rendering 관련된 ui는 layout 잡은 이후에 렌더링 되는데 이건 그럼 어느 시점에 작동해야하는거지..?
protocol UIBuilder {
    // RawValue가 String인 enum을 선언해야함. 이 안에서 enum으로 type들을
    associatedtype BuilderType: RawRepresentable where BuilderType.RawValue == String
    
    
}


