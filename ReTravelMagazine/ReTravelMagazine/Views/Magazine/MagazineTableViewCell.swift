//
//  MagazineTableViewCell.swift
//  ReTravelMagazine
//
//  Created by user on 6/1/24.
//

import UIKit

final class MagazineTableViewCell: UITableViewCell {
    
    let magazineImage: UIImageView = UIImageView()
    let title: UILabel = UILabel()
    let subtitle: UILabel = UILabel()
    let date: UILabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layoutComponents()
        setComponentsUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func layoutComponents() {
        layoutImageView()
        layoutTitle()
        layoutSubtitle()
        layoutDate()
    }
    
    private func setComponentsUI() {
        setMagazineImageUI()
        setTitleUI()
        setSubtitleUI()
        setDateUI()
    }
    
    private func layoutImageView() {
        self.addSubview(magazineImage)
        
        magazineImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            magazineImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            magazineImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            magazineImage.heightAnchor.constraint(equalTo: magazineImage.widthAnchor, multiplier: 1),
            magazineImage.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    private func layoutTitle() {
        self.addSubview(title)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: magazineImage.bottomAnchor, constant: 8),
            title.leadingAnchor.constraint(equalTo: magazineImage.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: magazineImage.trailingAnchor),
        ])
        
        title.text = "title"
        title.textColor = .black
    }
    
    private func layoutSubtitle() {
        self.addSubview(subtitle)
        
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            subtitle.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            subtitle.trailingAnchor.constraint(equalTo: title.trailingAnchor),
        ])
        
        subtitle.text = "subtitle"
        subtitle.textColor = .black
    }
    
    private func layoutDate() {
        self.addSubview(date)
        
        date.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            date.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: 8),
            date.leadingAnchor.constraint(equalTo: subtitle.leadingAnchor),
            date.trailingAnchor.constraint(equalTo: subtitle.trailingAnchor),
            date.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
        
        date.text = "date"
        date.textColor = .black
    }
    
    
    private func setMagazineImageUI() {
        magazineImage.backgroundColor = .systemGray4
        magazineImage.layer.cornerRadius = 12
        magazineImage.clipsToBounds = true
        magazineImage.layer.borderColor = UIColor.systemGray5.cgColor
        magazineImage.layer.borderWidth = 1
    }
    
    private func setTitleUI() {
        title.font = .systemFont(ofSize: 28, weight: .bold)
        title.numberOfLines = 0
    }
    
    private func setSubtitleUI() {
        subtitle.font = .systemFont(ofSize: 20, weight: .semibold)
        subtitle.textColor = .systemGray4
    }
    
    private func setDateUI() {
        date.font = .systemFont(ofSize: 16, weight: .medium)
        date.textColor = .systemGray4
        date.textAlignment = .right
    }
}
