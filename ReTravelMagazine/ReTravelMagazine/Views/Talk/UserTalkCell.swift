//
//  UserTalkCell.swift
//  ReTravelMagazine
//
//  Created by user on 6/3/24.
//

import UIKit

final class UserTalkCell: UITableViewCell {
    
    private let date: UILabel = UILabel()
    private let talkBackground: UIView = UIView()
    private let talk: UILabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layoutComponents()
        setComponentsUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutComponents() {
        layoutTalkBackground()
        layoutTalk()
        layoutDate()
    }
    
    private func setComponentsUI() {
        setTalkBackgroundUI()
        setTalkUI()
        setDateUI()
    }
    
    private func layoutTalkBackground() {
        self.addSubview(talkBackground)
        
        talkBackground.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            talkBackground.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            talkBackground.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
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
            date.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            date.trailingAnchor.constraint(equalTo: talkBackground.leadingAnchor, constant: -4),
            date.bottomAnchor.constraint(equalTo: talkBackground.bottomAnchor),
        ])
    }
    
    private func setTalkBackgroundUI() {
        talkBackground.layer.borderWidth = 1
        talkBackground.layer.borderColor = UIColor.systemGray3.cgColor
        talkBackground.layer.cornerRadius = 8
        talkBackground.clipsToBounds = true
        talkBackground.backgroundColor = .systemGray3
    }
    
    private func setTalkUI() {
        talk.font = .systemFont(ofSize: 12, weight: .medium)
        talk.numberOfLines = 0
    }
    
    private func setDateUI() {
        date.font = .systemFont(ofSize: 12, weight: .medium)
        date.textColor = .systemGray4
        date.textAlignment = .right
    }
    
    internal func configureData(_ data: Chat) {
        talk.text = data.message
        date.text = data.date
    }
}
