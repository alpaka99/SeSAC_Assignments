//
//  UserTalkCell.swift
//  ReTravelMagazine
//
//  Created by user on 6/3/24.
//

import UIKit

final class UserTalkCell: UITableViewCell {
    
    let date: UILabel = UILabel()
    let talk: UILabel = UILabel()
    
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
        self.addSubview(talk)
        
        talk.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            talk.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            talk.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            talk.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            talk.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 0.75)
        ])
        
        talk.numberOfLines = 0
        talk.layer.borderWidth = 1
        talk.layer.borderColor = UIColor.systemGray3.cgColor
        talk.layer.cornerRadius = 8
        talk.clipsToBounds = true
        talk.backgroundColor = .systemGray3
        talk.text = "test message test message test message test message test message test message test message test message test message test message"
    }
    
    private func layoutDate() {
        self.addSubview(date)
        
        date.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            date.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            date.trailingAnchor.constraint(equalTo: talk.leadingAnchor, constant: -4),
            date.bottomAnchor.constraint(equalTo: talk.bottomAnchor),
        ])
        
        date.text = Date.now.formatted()
    }
}
