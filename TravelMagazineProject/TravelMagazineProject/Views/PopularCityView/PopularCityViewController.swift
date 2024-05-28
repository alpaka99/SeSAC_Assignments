//
//  PopularCityViewController.swift
//  TravelMagazineProject
//
//  Created by user on 5/27/24.
//

import UIKit

class PopularCityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let travels = TravelInfo().travel
    
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationItemUI(.travel)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let cityCellXib = UINib(nibName: PopularCityTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(cityCellXib, forCellReuseIdentifier: PopularCityTableViewCell.reuseIdentifier)
        
        let adCellXib = UINib(nibName: PopularCityAdCell.reuseIdentifier, bundle: nil)
        tableView.register(adCellXib, forCellReuseIdentifier: PopularCityAdCell.reuseIdentifier)
        
        tableView.rowHeight = 100
    }
    
    private func setNavigationItemUI(_ type: NavigationItemType) {
        navigationItem.title = type.title
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travels.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = travels[indexPath.row]
        
        
        // MARK: deque reusable cell을 좀 더 간단하게 초기화 하는 방법은 없을까...?
        if data.ad == true { // ad cell
            if let cell = tableView.dequeueReusableCell(withIdentifier: PopularCityAdCell.reuseIdentifier, for: indexPath) as? PopularCityAdCell {
                
                cell.configureData(data)
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath) as UITableViewCell
                
                cell.textLabel?.text = "Something went wrong...😞"
                
                return cell
            }
        } else { // popular city cell
            if let cell = tableView.dequeueReusableCell(withIdentifier: PopularCityTableViewCell.reuseIdentifier, for: indexPath) as? PopularCityTableViewCell {
                
                cell.configureData(data)
                                
                return cell
            }
                else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath) as UITableViewCell
                
                cell.textLabel?.text = "Something went wrong...😞"
                
                return cell
            }
        }
    }
}
