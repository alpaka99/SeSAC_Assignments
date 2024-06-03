//
//  TravelCityViewController.swift
//  TravelMagazineProject
//
//  Created by user on 5/27/24.
//

import UIKit

class TravelCityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let travels = TravelInfo().travel
    
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationItemUI(.travel)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let cityCellXib = UINib(nibName: TravelCityTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(cityCellXib, forCellReuseIdentifier: TravelCityTableViewCell.reuseIdentifier)
        
        let adCellXib = UINib(nibName: TravelCityAdCell.reuseIdentifier, bundle: nil)
        tableView.register(adCellXib, forCellReuseIdentifier: TravelCityAdCell.reuseIdentifier)
        
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
            if let cell = tableView.dequeueReusableCell(withIdentifier: TravelCityAdCell.reuseIdentifier, for: indexPath) as? TravelCityAdCell {
                
                cell.configureData(data)
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath) as UITableViewCell
                
                cell.textLabel?.text = BasicCellInfo.text
                
                return cell
            }
        } else { // travel city cell
            if let cell = tableView.dequeueReusableCell(withIdentifier: TravelCityTableViewCell.reuseIdentifier, for: indexPath) as? TravelCityTableViewCell {
                
                cell.configureData(data)
                                
                return cell
            }
                else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath) as UITableViewCell
                
                    cell.textLabel?.text = BasicCellInfo.text
                
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = travels[indexPath.row]
        
        if data.ad {
            if let vc = storyboard?.instantiateViewController(withIdentifier: DetailAdViewController.reuseIdentifier) as? DetailAdViewController {
                
                if let cell = tableView.cellForRow(at: indexPath) as? TravelCityAdCell {
                    let cellColor = cell.adTitleLabel.backgroundColor
                    
                    vc.configureData(data, backgroundColor: cellColor ?? UIColor.getRandomColor())
                    
                    navigationController?.pushViewController(vc, animated: true)
                }
            }
            
        } else {
            if let vc = storyboard?.instantiateViewController(identifier: DetailCityViewController.reuseIdentifier) as? DetailCityViewController {
                
                vc.configureData(data)
                
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                present(nav, animated: true)
            }
            
        }
    }
}
