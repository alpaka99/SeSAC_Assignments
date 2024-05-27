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
        
        let xib = UINib(nibName: "PopularCityTableViewCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "PopularCityTableViewCell")
        
        tableView.rowHeight = 100
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travels.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PopularCityTableViewCell", for: indexPath) as? PopularCityTableViewCell {
            
            cell.titleLabel.text = "텍스트테스트"
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath) as UITableViewCell
            
            cell.textLabel?.text = "Something went wrong...😞"
            
            return cell
        }
    }
}
