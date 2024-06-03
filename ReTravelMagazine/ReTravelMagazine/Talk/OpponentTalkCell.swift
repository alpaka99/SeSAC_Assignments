//
//  OpponentTalkCell.swift
//  ReTravelMagazine
//
//  Created by user on 6/3/24.
//

import UIKit

final class OpponentTalkCell: UITableViewCell {
    
    private let profileImage: UIImageView = UIImageView()
    private let name: UILabel = UILabel()
    private let talk: UILabel = UILabel()
    private let date: UILabel = UILabel()
    
    var talkCellType: TalkCellType = .received
    
    private let padding: UIEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        configureData()
        
        layoutComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureData() {
        
    }
    
    private func layoutComponents() {
        layoutProfileImage()
        layoutName()
        layoutTalk()
        layoutDate()
    }
    
    private func layoutProfileImage() {
        self.addSubview(profileImage)
        
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            profileImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1),
            profileImage.heightAnchor.constraint(equalTo: profileImage.widthAnchor, multiplier: 1)
        ])
        
        profileImage.backgroundColor = .systemGray4
    }
    
    private func layoutName() {
        self.addSubview(name)
        
        name.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: profileImage.topAnchor),
            name.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 4),
        ])
        
        name.text = "test name"
    }
    
    private func layoutTalk() {
        self.addSubview(talk)
        
        talk.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            talk.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 4),
            talk.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            talk.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
        
        talk.text = "test talk test talk test talk test talk test talk test talk"
        talk.numberOfLines = 0
        talk.layer.borderWidth = 1
        talk.layer.borderColor = UIColor.systemGray3.cgColor
        talk.layer.cornerRadius = 8
        talk.clipsToBounds = true
        
    }
    
    private func layoutDate() {
        self.addSubview(date)
        
        date.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            date.leadingAnchor.constraint(equalTo: talk.trailingAnchor, constant: 4),
            date.bottomAnchor.constraint(equalTo: talk.bottomAnchor),
            date.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        ])
        
        date.text = Date.now.formatted()
    }
}


enum TalkCellType {
    case received
    case send
}
