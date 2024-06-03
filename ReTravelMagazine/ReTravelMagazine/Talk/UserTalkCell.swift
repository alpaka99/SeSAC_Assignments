//
//  UserTalkCell.swift
//  ReTravelMagazine
//
//  Created by user on 6/3/24.
//

import UIKit

final class UserTalkCell: UITableViewCell {
    
    let date: UILabel = UILabel()
    let message: UILabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layoutComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutComponents() {
        layoutMessage()
        layoutDate()
    }
    
    private func layoutMessage() {
        self.addSubview(message)
        
        message.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            message.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            message.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            message.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
        ])
        
        message.numberOfLines = 0
        message.layer.borderWidth = 1
        message.layer.borderColor = UIColor.systemGray3.cgColor
        message.layer.cornerRadius = 8
        message.clipsToBounds = true
        message.backgroundColor = .systemGray3
        message.text = "test message test message test message test message test message test message test message test message test message test message"
    }
    
    private func layoutDate() {
        self.addSubview(date)
        
        date.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            date.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            date.trailingAnchor.constraint(equalTo: message.leadingAnchor, constant: -4),
            date.bottomAnchor.constraint(equalTo: message.bottomAnchor),
        ])
        
        date.text = Date.now.formatted()
    }
}
