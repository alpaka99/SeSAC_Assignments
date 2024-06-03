//
//  TalkTableViewCell.swift
//  ReTravelMagazine
//
//  Created by user on 6/2/24.
//

import UIKit

final class TalkTableViewCell: UITableViewCell {
    
    let image: UIImageView = UIImageView()
    let name: UILabel = UILabel()
    let message: UILabel = UILabel()
    let date: UILabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layoutComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setComponentsUI()
    }
    
    private func layoutComponents() {
        layoutImage()
        layoutName()
        layoutMessage()
        layoutDate()
    }
    
    private func setComponentsUI() {
        setImageUI()
        setNameUI()
        setMessageUI()
        setDateUI()
    }
    
    private func layoutImage() {
        self.addSubview(image)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            image.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            image.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1),
            image.heightAnchor.constraint(equalTo: image.widthAnchor, multiplier: 1)
        ])
    }
    
    // MARK: 여기서 constraint warning이 발생 -> 원인: UILabel들의 height가 모호하다 (cell height를 결정하던지, label height들을 결정해주면 될 것 같은데 어떤게 좋을지 모르겠습니다...!)
    private func layoutName() {
        self.addSubview(name)
        
        name.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: image.topAnchor, constant: 4),
            name.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 4),
        ])
    }
    
    private func layoutMessage() {
        self.addSubview(message)
        
        message.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            message.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 4),
            message.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            message.bottomAnchor.constraint(equalTo: image.bottomAnchor, constant: -4),
        ])
    }
    
    private func layoutDate() {
        self.addSubview(date)
        
        date.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            date.topAnchor.constraint(equalTo: name.topAnchor),
            date.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        ])
        
        date.text = String(describing: Date.now.formatted())
    }
    
    private func setImageUI() {
        image.backgroundColor = .systemGray4
        image.layer.cornerRadius = image.frame.width / 2
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
    }
    
    private func setNameUI() {
        name.font = .systemFont(ofSize: 12, weight: .semibold)
        name.numberOfLines = 1
    }
    
    private func setMessageUI() {
        message.font = .systemFont(ofSize: 12, weight: .semibold)
        message.textColor = .systemGray3
        message.numberOfLines = 1
    }
    
    private func setDateUI() {
        date.font = .systemFont(ofSize: 10, weight: .regular)
        date.textColor = .systemGray4
        date.textAlignment = .right
    }
    
    internal func configureData(_ data: ChatRoom) {
        if let chatRoomImage = data.chatroomImage.first {
            image.image = UIImage(named: chatRoomImage)
        }
        
        name.text = data.chatroomName
        
        if let lastMessage = data.chatList.last {
            message.text = lastMessage.message
        }
    }
}
