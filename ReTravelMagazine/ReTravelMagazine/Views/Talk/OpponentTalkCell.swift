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
    private let talkBackground: UIView = UIView()
    private let talk: UILabel = UILabel()
    private let date: UILabel = UILabel()
    
    private let padding: UIEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layoutComponents()
        setComponentsUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
    }
    
    private func layoutComponents() {
        layoutProfileImage()
        layoutName()
        layoutTalkBackground()
        layoutTalk()
        layoutDate()
    }
    
    private func setComponentsUI() {
        setProfileImageUI()
        setNameUI()
        setTalkBackgroundUI()
        setTalkUI()
        setDateUI()
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
    }
    
    private func layoutTalkBackground() {
        self.addSubview(talkBackground)
        
        talkBackground.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            talkBackground.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 4),
            talkBackground.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            talkBackground.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            talkBackground.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 0.75)
        ])
    }
    
    private func layoutTalk() {
        talkBackground.addSubview(talk)
        
        talk.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            talk.topAnchor.constraint(equalTo: talkBackground.topAnchor, constant: 8),
            talk.leadingAnchor.constraint(equalTo: talkBackground.leadingAnchor, constant: 8),
            talk.trailingAnchor.constraint(equalTo: talkBackground.trailingAnchor, constant: -8),
            talk.bottomAnchor.constraint(equalTo: talkBackground.bottomAnchor, constant: -8),
        ])
    }
    
    private func layoutDate() {
        self.addSubview(date)
        
        date.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            date.leadingAnchor.constraint(equalTo: talkBackground.trailingAnchor, constant: 4),
            date.bottomAnchor.constraint(equalTo: talkBackground.bottomAnchor),
        ])
        
    }
    
    private func setProfileImageUI() {
        profileImage.contentMode = .scaleAspectFill
        profileImage.backgroundColor = .systemGray4
        profileImage.clipsToBounds = true
    }
    
    private func setNameUI() {
        name.font = .systemFont(ofSize: 12, weight: .medium)
    }
    
    private func setTalkBackgroundUI() {
        talkBackground.layer.borderWidth = 1
        talkBackground.layer.borderColor = UIColor.systemGray3.cgColor
        talkBackground.layer.cornerRadius = 8
        talkBackground.clipsToBounds = true
    }
    
    private func setTalkUI() {
        talk.font = .systemFont(ofSize: 12, weight: .medium)
        talk.numberOfLines = 0
    }
    
    private func setDateUI() {
        date.font = .systemFont(ofSize: 12, weight: .regular)
        date.textColor = .systemGray4
        date.text = Date.now.formatted()
    }
    
    internal func configureData(_ data: Chat) {
        profileImage.image = UIImage(named: data.user.profileImage)
        name.text = data.user.rawValue
        talk.text = data.message
        date.text = data.date
    }
}
