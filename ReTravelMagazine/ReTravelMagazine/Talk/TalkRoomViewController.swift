//
//  TalkRoomViewController.swift
//  ReTravelMagazine
//
//  Created by user on 6/3/24.
//

import UIKit

final class TalkRoomViewController: UIViewController {
    
    let tableView: UITableView = UITableView()
    
    override func loadView() {
        super.loadView()
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
        tableView.delegate  = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
        tableView.register(OpponentTalkCell.self, forCellReuseIdentifier: OpponentTalkCell.reuseIdentifier)
        tableView.register(UserTalkCell.self, forCellReuseIdentifier: UserTalkCell.reuseIdentifier)
    }
}

extension TalkRoomViewController: UITableViewDelegate, UITableViewDataSource {
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 3 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: UserTalkCell.reuseIdentifier, for: indexPath)
            print(#function)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: OpponentTalkCell.reuseIdentifier, for: indexPath) as! OpponentTalkCell
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
