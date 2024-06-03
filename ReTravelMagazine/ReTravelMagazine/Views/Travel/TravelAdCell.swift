//
//  TravelAdCell.swift
//  ReTravelMagazine
//
//  Created by user on 6/2/24.
//

import UIKit

final class TravelAdCell: UITableViewCell {
    private let title: UILabel = UILabel()
    private let badge: UILabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layoutComponents()
        setComponentsUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutComponents() {
        layoutTitle()
        layoutBadge()
    }
    
    private func setComponentsUI() {
        setTitleUI()
        setBadgeUI()
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
    }
    
    private func layoutBadge() {
        self.addSubview(badge)
        
        badge.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            badge.topAnchor.constraint(equalTo: title.topAnchor, constant: 4),
            badge.trailingAnchor.constraint(equalTo: title.trailingAnchor, constant: -4),
            badge.widthAnchor.constraint(equalTo: title.widthAnchor, multiplier: 0.1)
        ])
    }
    
    private func setTitleUI() {
        title.backgroundColor = UIColor.randomColor
        title.numberOfLines = 0
        title.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        title.textAlignment = .center
        title.layer.cornerRadius = 8
        title.clipsToBounds = true
    }
    
    private func setBadgeUI() {
        badge.text = "Ad"
        badge.font = .systemFont(ofSize: 12, weight: .bold)
        badge.textAlignment = .center
        badge.backgroundColor = .white
        badge.layer.cornerRadius = 4
        badge.clipsToBounds = true
    }
    
    internal func configureData(_ data: Travel) {
        title.text = data.title
    }
}
