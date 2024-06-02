//
//  TalkViewController.swift
//  ReTravelMagazine
//
//  Created by user on 6/1/24.
//

import UIKit

final class TalkViewController: UIViewController {
    
    let searchBar: UISearchBar = UISearchBar()
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
        layoutSearchBar()
        layoutTableView()
    }
    
    private func layoutSearchBar() {
        view.addSubview(searchBar)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func layoutTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func configureComponents() {
        configureNavigationItem()
        configureSearchBar()
        configureTableView()
    }
    
    private func configureNavigationItem() {
        navigationItem.title = "SeSAC Talk"
    }
    
    private func configureSearchBar() {
        searchBar.placeholder = "친구 이름을 검색해보세요"
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
        tableView.register(TalkTableViewCell.self, forCellReuseIdentifier: TalkTableViewCell.reuseIdentifier)
    }
}


extension TalkViewController: UISearchBarDelegate {
    
}

extension TalkViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TalkTableViewCell.reuseIdentifier, for: indexPath) as! TalkTableViewCell
        
//        cell.textLabel?.text = "talk text"
        
        return cell
    }
}
