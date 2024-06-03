//
//  TravelAdCell.swift
//  ReTravelMagazine
//
//  Created by user on 6/2/24.
//

import UIKit

final class TravelAdCell: UITableViewCell {
    let title: UILabel = UILabel()
    let badge: UILabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layoutComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutComponents() {
        layoutTitle()
        layoutBadge()
    }
    
    private func layoutTitle() {
        self.addSubview(title)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
        ])
        
        title.backgroundColor = .systemIndigo
        title.numberOfLines = 0
        title.text = "ad title"
        title.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
        title.textAlignment = .center
    }
    
    private func layoutBadge() {
        self.addSubview(badge)
        
        badge.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            badge.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            badge.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
        ])
        
        badge.text = "Ad"
        badge.backgroundColor = .systemGreen
    }
}
