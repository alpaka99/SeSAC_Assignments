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
    
    private func layoutComponents() {
        layoutImage()
        layoutName()
        layoutMessage()
        layoutDate()
    }
    
    private func layoutImage() {
        self.addSubview(image)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            image.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            image.widthAnchor.constraint(equalTo: image.heightAnchor, multiplier: 1)
        ])
        
        image.backgroundColor = .systemMint
    }
    
    private func layoutName() {
        self.addSubview(name)
        
        name.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: image.topAnchor, constant: 4),
            name.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 4),
        ])
        
        name.text = "name test"
    }
    
    private func layoutMessage() {
        self.addSubview(message)
        
        message.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            message.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 4),
            message.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            message.bottomAnchor.constraint(equalTo: image.bottomAnchor, constant: -4),
        ])
        
        message.text = "test message"
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
}
