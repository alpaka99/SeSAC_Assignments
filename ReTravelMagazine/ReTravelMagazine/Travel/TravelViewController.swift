//
//  TravelViewController.swift
//  ReTravelMagazine
//
//  Created by user on 6/1/24.
//

import UIKit

final class TravelViewController: UIViewController {
    
    let tableView: UITableView = UITableView()
    
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
        configureNavigationItem()
        configureTableView()
    }
    
    private func configureNavigationItem() {
        navigationItem.title = "SeSAC Travel"
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
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TravelTableViewCell.reuseIdentifier, for: indexPath) as! TravelTableViewCell

            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TravelAdCell.reuseIdentifier, for: indexPath) as! TravelAdCell
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
