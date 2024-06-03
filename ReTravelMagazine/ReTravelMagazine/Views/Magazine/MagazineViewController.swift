//
//  MagazineViewController.swift
//  ReTravelMagazine
//
//  Created by user on 6/1/24.
//

import UIKit

final class MagazineViewController: UIViewController {
    
    private let tableView: UITableView = UITableView()
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "SeSAC Magazine"
        
        layoutComponents()
        setComponentsUI()
        configureComponents()
    }
    
    private func layoutComponents() {
        layoutTableView()
    }
    
    private func setComponentsUI() {
        
    }
    
    private func configureComponents() {
        configureTableView()
    }
    
    private func layoutTableView() {
        self.view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
        tableView.register(MagazineTableViewCell.self, forCellReuseIdentifier: MagazineTableViewCell.reuseIdentifier)
    }
}

extension MagazineViewController: UITableViewDelegate, UITableViewDataSource {
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: MagazineTableViewCell.reuseIdentifier, for: indexPath) as? MagazineTableViewCell {
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath) as UITableViewCell
            
            cell.textLabel?.text = "Magazine"
            
            return cell
        }
    }
    
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MagazineDetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

