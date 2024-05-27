//
//  FoodViewController.swift
//  Day7Assignments
//
//  Created by user on 5/27/24.
//

import UIKit

class FoodViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var foodTableView: UITableView!
    
    var list = RestaurantList().restaurantArray
    var filteredList: [Restaurant] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftBarButton = UIBarButtonItem(title: "한식만 보기", style: .plain, target: self, action: #selector(leftBarButtonItemClicked))
        let allBarButton = UIBarButtonItem(title: "전체 보기", style: .plain, target: self, action: #selector(allBarButtonClicked))
        navigationItem.leftBarButtonItems = [ leftBarButton, allBarButton ]
        
        
        filteredList = list
        
        foodTableView.rowHeight = 50
        foodTableView.delegate = self
        foodTableView.dataSource = self
        searchBar.delegate = self
        
        let xib = UINib(nibName: "FoodTableViewCell", bundle: nil)
        foodTableView.register(xib, forCellReuseIdentifier: "FoodTableViewCell")
        
        
        self.setBackground()
    }
    
    @objc
    func leftBarButtonItemClicked() {
        // list > 반복문 > 한식에 해당하는 것들만 찾기 > 갱신
        
        var koreanFood: [Restaurant] = []
        
        for item in list {
            if item.category == "한식" {
                koreanFood.append(item)
            }
        }
//        print(koreanFood)
        filteredList = koreanFood
        foodTableView.reloadData()
        
//        list = list.filter { item in
//            item.category == "한식"
//        }
        self.showAlert(title: "한식보기 버튼을 클릭하셨습니다")
    }
    
    @objc
    func allBarButtonClicked() {
        filteredList = list
        foodTableView.reloadData()
        self.showAlert(title: "전체보기 버튼을 클릭하셨습니다")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        var searchList: [Restaurant] = []
        
        for item in list {
            if let text = searchBar.text {
                if item.name.contains(text) || item.category.contains(text) {
                    searchList.append(item)
                }
            }
        }
        
        filteredList = searchList
        foodTableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print(#function)
        var searchList: [Restaurant] = []
        
        for item in list {
            if let text = searchBar.text {
                if item.name.contains(text) || item.category.contains(text) {
                    searchList.append(item)
                }
            }
        }
        
        filteredList = searchList
        foodTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodTableViewCell", for: indexPath) as! FoodTableViewCell
        
        let data = filteredList[indexPath.row]
        
//        cell.configureLayout()
        cell.configureCell(data)
        
        return cell
    }
    
}
