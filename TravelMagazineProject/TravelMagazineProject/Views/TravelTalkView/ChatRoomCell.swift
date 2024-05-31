//
//  ChatRoomCell.swift
//  TravelMagazineProject
//
//  Created by user on 5/31/24.
//

import UIKit

final class ChatRoomCell: UITableViewCell {
    
    let chatRoomThumbnail: UIImageView = UIImageView()
    
    let chatRoomTitle: UILabel = UILabel()
    let chatRoomMessage: UILabel = UILabel()
    
    let chatRoomDate: UILabel = UILabel()
    
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
        self.addSubview(chatRoomThumbnail)
        
        chatRoomThumbnail.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            chatRoomThumbnail.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            chatRoomThumbnail.leadingAnchor .constraint(equalTo: self.leadingAnchor, constant: 16),
            chatRoomThumbnail.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            
            
            chatRoomThumbnail.widthAnchor.constraint(equalTo: chatRoomThumbnail.heightAnchor, multiplier: 1)
        ])
        
        chatRoomThumbnail.backgroundColor = .red
    }
    
    
    private func layoutChatRoomTitle() {
        self.addSubview(chatRoomTitle)
        
        chatRoomTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            chatRoomTitle.topAnchor.constraint(equalTo: chatRoomThumbnail.topAnchor, constant: 4),
            chatRoomTitle.leadingAnchor.constraint(equalTo: chatRoomThumbnail.trailingAnchor, constant: 4),
        ])
        
        chatRoomTitle.text = "Hue"
        chatRoomTitle.backgroundColor = .systemOrange
    }
    
    private func layoutChatRoomMesssage() {
        self.addSubview(chatRoomMessage)
        
        chatRoomMessage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            chatRoomMessage.topAnchor.constraint(equalTo: chatRoomTitle.bottomAnchor, constant: 8),
            chatRoomMessage.leadingAnchor.constraint(equalTo: chatRoomTitle.leadingAnchor),
            chatRoomMessage.bottomAnchor.constraint(equalTo: chatRoomThumbnail.bottomAnchor, constant: -4),
        ])
        
        chatRoomMessage.text = "왜요? 요즘 코딩이 대세인데"
        chatRoomMessage.backgroundColor = .systemBlue
    }
    
    private func layoutChatRoomDate() {
        self.addSubview(chatRoomDate)
        
        chatRoomDate.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            chatRoomDate.centerYAnchor.constraint(equalTo: chatRoomTitle.centerYAnchor),
            chatRoomDate.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
        ])
        
        chatRoomDate.text = "24.01.12"
        chatRoomDate.backgroundColor = .green
    }
}
