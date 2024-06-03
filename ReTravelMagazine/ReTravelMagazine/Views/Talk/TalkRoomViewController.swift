//
//  TalkRoomViewController.swift
//  ReTravelMagazine
//
//  Created by user on 6/3/24.
//

import UIKit

final class TalkRoomViewController: UIViewController {
    
    private let tableView: UITableView = UITableView()
    private var chats: [Chat] = []
    
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
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
        tableView.scrollToRow(at: IndexPath(row: chats.count-1, section: 0), at: .bottom, animated: true)
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
        
        tableView.separatorColor = .clear
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
        tableView.register(OpponentTalkCell.self, forCellReuseIdentifier: OpponentTalkCell.reuseIdentifier)
        tableView.register(UserTalkCell.self, forCellReuseIdentifier: UserTalkCell.reuseIdentifier)
    }
    
    internal func configureData(_ data: [Chat]) {
        chats = data
    }
}

extension TalkRoomViewController: UITableViewDelegate, UITableViewDataSource {
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = chats[indexPath.row]
        
        if data.user == .user {
            let cell = tableView.dequeueReusableCell(withIdentifier: UserTalkCell.reuseIdentifier, for: indexPath) as! UserTalkCell
            
            cell.configureData(data)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: OpponentTalkCell.reuseIdentifier, for: indexPath) as! OpponentTalkCell
            
            cell.configureData(data)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
