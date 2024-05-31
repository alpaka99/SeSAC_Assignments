//
//  TravelTalkViewController.swift
//  TravelMagazineProject
//
//  Created by user on 5/31/24.
//

import UIKit

final class TravelTalkViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    let talkSearchBar: UISearchBar = UISearchBar()
    let talkTableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationItems()
        configureSearchBar()
        configureTalkTableView()
        
        layoutTalkSearchbar()
        layoutTalkTableView()
    }
    
    private func configureNavigationItems() {
        navigationItem.title = "트레블톡"
    }
    
    private func configureSearchBar() {
        talkSearchBar.delegate = self
    }
    
    private func configureTalkTableView() {
        talkTableView.delegate = self
        talkTableView.dataSource = self
        
        talkTableView.rowHeight = 100
        
        talkTableView.register(ChatRoomCell.self, forCellReuseIdentifier: ChatRoomCell.reuseIdentifier)
        talkTableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
    }
    
    private func layoutTalkSearchbar() {
        self.view.addSubview(talkSearchBar)
        
        talkSearchBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            talkSearchBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: ScreenSize.navigationBarConstant),
            talkSearchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            talkSearchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
        ])
        
        talkSearchBar.placeholder = "친구 이름을 검색해보세요"
    }
    
    private func layoutTalkTableView() {
        self.view.addSubview(talkTableView)
        
        talkTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            talkTableView.topAnchor.constraint(equalTo: self.talkSearchBar.bottomAnchor),
            talkTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            talkTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            talkTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ChatRoomCell.reuseIdentifier, for: indexPath) as? ChatRoomCell {
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath) as UITableViewCell
            
            cell.textLabel?.text = BasicCellInfo.text
            
            return cell
        }
    }
}
