//
//  TravelViewController.swift
//  ReTravelMagazine
//
//  Created by user on 6/1/24.
//

import UIKit

final class TravelViewController: UIViewController {
    
    private let tableView: UITableView = UITableView()
    private let travels: [Travel] = TravelInfo().travel
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutComponents()
        
        configureComponents()
    }
    
    private func layoutComponents() {
        layoutTableView()
    }
    
    private func layoutTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    
    private func configureComponents() {
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
        tableView.register(TravelTableViewCell.self, forCellReuseIdentifier: TravelTableViewCell.reuseIdentifier)
        tableView.register(TravelAdCell.self, forCellReuseIdentifier: TravelAdCell.reuseIdentifier)
    }
}


extension TravelViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = travels[indexPath.row]
        
        if data.ad {
            if let cell = tableView.dequeueReusableCell(withIdentifier: TravelAdCell.reuseIdentifier, for: indexPath) as? TravelAdCell {
                
                cell.configureData(data)
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath) as UITableViewCell
                
                cell.textLabel?.text = TableViewCellConstants.basicCellText
                
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: TravelTableViewCell.reuseIdentifier, for: indexPath) as? TravelTableViewCell {
                
                cell.configureData(data)
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath) as UITableViewCell
                
                cell.textLabel?.text = TableViewCellConstants.basicCellText
                
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
