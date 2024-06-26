//
//  TalkViewController.swift
//  ReTravelMagazine
//
//  Created by user on 6/1/24.
//

import UIKit

final class TalkViewController: UIViewController {
    
    private let searchBar: UISearchBar = UISearchBar()
    private let tableView: UITableView = UITableView()
    
    private let chatRooms: [ChatRoom] = mockChatList
    private lazy var filteredChatRooms: [ChatRoom] = chatRooms {
        didSet {
            tableView.reloadData()
        }
    }
    
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
        configureSearchBar()
        configureTableView()
    }
    
    private func configureSearchBar() {
        searchBar.delegate = self
        
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
    internal func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterChatList(searchText)
    }
    
    private func filterChatList(_ searchText: String) {
        if searchText.isEmpty {
            filteredChatRooms = chatRooms
        } else {
            filteredChatRooms = chatRooms.filter { chatRoom in
                chatRoom.chatRoomUsers.localizedStandardContains(searchText) || chatRoom.chatRoomMessages.localizedStandardContains(searchText)
            }
        }
    }
    
}

extension TalkViewController: UITableViewDelegate, UITableViewDataSource {
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredChatRooms.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TalkTableViewCell.reuseIdentifier, for: indexPath) as! TalkTableViewCell
        
        let data = filteredChatRooms[indexPath.row]
        
        cell.configureData(data)
        
        return cell
    }
    
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TalkRoomViewController()
        
        let data = chatRooms[indexPath.row].chatList
        vc.configureData(data)
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
