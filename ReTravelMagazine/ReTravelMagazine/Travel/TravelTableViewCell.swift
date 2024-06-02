//
//  TravelTableViewCell.swift
//  ReTravelMagazine
//
//  Created by user on 6/2/24.
//

import UIKit

// MARK: 그냥 view에다가 add하면 contentView가 간섭함. -> 그러면? 그냥 contentView 위에 얹으면 됨
final class TravelTableViewCell: UITableViewCell {
    let title: UILabel = UILabel()
    let subtitle: UILabel = UILabel()
    let grade: UILabel = UILabel()
    let image: UIImageView = UIImageView()
    let likeButton: UIButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layoutComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutComponents() {
        layoutTitle()
        layoutSubTitle()
        layoutGrade()
        layoutImage()
        layoutLikeButton()
    }
    
    private func layoutTitle() {
        self.contentView.addSubview(title)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            title.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
        ])
        
        title.text = "test title"
    }
    
    private func layoutSubTitle() {
        self.contentView.addSubview(subtitle)
        
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4),
            subtitle.leadingAnchor.constraint(equalTo: title.leadingAnchor),
        ])
        
        subtitle.text = "test subtitle"
    }
    
    
    private func layoutGrade() {
        self.contentView.addSubview(grade)
        
        grade.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            grade.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: 8),
            grade.leadingAnchor.constraint(equalTo: subtitle.leadingAnchor),
            grade.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant: -8),
        ])
        
        grade.text = "test grade"
    }
    
    private func layoutImage() {
        self.contentView.addSubview(image)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            image.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            image.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            image.widthAnchor.constraint(equalTo: image.heightAnchor, multiplier: 0.7)
        ])
        
        image.backgroundColor = .systemGray4
    }
    
    private func layoutLikeButton() {
        self.contentView.addSubview(likeButton)
        
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            likeButton.topAnchor.constraint(equalTo: image.topAnchor, constant: 4),
            likeButton.trailingAnchor.constraint(equalTo: image.trailingAnchor, constant: -4),
            likeButton.heightAnchor.constraint(equalToConstant: 20),
            likeButton.widthAnchor.constraint(equalTo: likeButton.heightAnchor, multiplier: 1)
        ])
        
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        likeButton.setImage(UIImage(named: "heart"), for: .normal)
        likeButton.tintColor = .white
        likeButton.backgroundColor = .systemIndigo
    }
    
    @objc
    func likeButtonTapped() {
        print(#function)
    }
}
