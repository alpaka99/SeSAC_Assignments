//
//  ChatRoomCell.swift
//  TravelMagazineProject
//
//  Created by user on 5/31/24.
//

import UIKit

final class TalkRoomCell: UITableViewCell {
    
    private var thumbnail: UIImageView = UIImageView()
    
    private var title: UILabel = UILabel()
    private var lastMessage: UILabel = UILabel()
    
    private var updatedAt: UILabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // initialze code
        
        layoutComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func layoutComponents() {
        layoutChatRoomThumbnail()
        layoutChatRoomTitle()
        layoutChatRoomMesssage()
        layoutChatRoomDate()
    }
    
    private func layoutChatRoomThumbnail() {
        self.addSubview(thumbnail)
        
        thumbnail.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            thumbnail.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            thumbnail.leadingAnchor .constraint(equalTo: self.leadingAnchor, constant: 16),
            thumbnail.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            
            
            thumbnail.widthAnchor.constraint(equalTo: thumbnail.heightAnchor, multiplier: 1)
        ])
        
        thumbnail.backgroundColor = .red
    }
    
    
    private func layoutChatRoomTitle() {
        self.addSubview(title)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: thumbnail.topAnchor, constant: 0),
            title.leadingAnchor.constraint(equalTo: thumbnail.trailingAnchor, constant: 4),
        ])
        
        title.text = "Hue"
        title.backgroundColor = .systemOrange
    }
    
    private func layoutChatRoomMesssage() {
        self.addSubview(lastMessage)
        
        lastMessage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lastMessage.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4),
            lastMessage.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            lastMessage.bottomAnchor.constraint(equalTo: thumbnail.bottomAnchor, constant: -4),
        ])
        
        lastMessage.text = "왜요? 요즘 코딩이 대세인데"
        lastMessage.backgroundColor = .systemBlue
    }
    
    private func layoutChatRoomDate() {
        self.addSubview(updatedAt)
        
        updatedAt.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            updatedAt.centerYAnchor.constraint(equalTo: title.centerYAnchor),
            updatedAt.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4),
        ])
        
        updatedAt.text = "24.01.12"
        updatedAt.backgroundColor = .green
    }
    
    internal func configureData(_ data: ChatRoom) {
//        thumbnail.image = UIImage(sys)
        title.text = data.chatroomName
        lastMessage.text = data.chatList.last?.message
        updatedAt.text = data.chatList.last?.formattedDate
    }
}
