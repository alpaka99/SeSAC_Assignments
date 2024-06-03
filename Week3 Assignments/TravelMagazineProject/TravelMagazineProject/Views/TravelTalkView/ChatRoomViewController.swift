//
//  ChatRoomViewController.swift
//  TravelMagazineProject
//
//  Created by user on 5/31/24.
//

import UIKit

final class ChatRoomViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let chatTableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white // 왜 background가 자동으로 설정 안될까 흠...
        
        configureNavigationItems()
        
        configureChatTableView()
        
        
        layoutChatTableView()
    }
    
    private func configureNavigationItems() {
        navigationItem.title = "Den"
    }
    
    private func configureChatTableView() {
        chatTableView.delegate = self
        chatTableView.dataSource = self
        
        chatTableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
    }
    
    private func layoutChatTableView() {
        self.view.addSubview(chatTableView)
        
        chatTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            chatTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: ScreenSize.navigationBarConstant),
            chatTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            chatTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            chatTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = "테스트"
        
        return cell
    }
}
