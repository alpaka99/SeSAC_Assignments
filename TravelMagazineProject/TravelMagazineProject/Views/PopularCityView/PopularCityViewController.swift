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
        
        navigationItem.title = "도시 상세 정보"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let cityCellXib = UINib(nibName: "PopularCityTableViewCell", bundle: nil)
        tableView.register(cityCellXib, forCellReuseIdentifier: "PopularCityTableViewCell")
        
        let adCellXib = UINib(nibName: "PopularCityAdCell", bundle: nil)
        tableView.register(adCellXib, forCellReuseIdentifier: "PopularCityAdCell")
        
        tableView.rowHeight = 100
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travels.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = travels[indexPath.row]
        
        
        if data.ad { // ad cell
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PopularCityAdCell", for: indexPath) as? PopularCityAdCell {
                
                cell.configureData(data)
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as UITableViewCell
                
                cell.textLabel?.text = "Something went wrong...😞"
                
                return cell
            }
        } else { // popular city cell
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PopularCityTableViewCell", for: indexPath) as? PopularCityTableViewCell {
                
                cell.configureData(data)
                                
                return cell
            }
                else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as UITableViewCell
                
                cell.textLabel?.text = "Something went wrong...😞"
                
                return cell
            }
        }
    }
}
