//
//  TravelTableViewCell.swift
//  ReTravelMagazine
//
//  Created by user on 6/2/24.
//

import UIKit

final class TravelTableViewCell: UITableViewCell {
    private let title: UILabel = UILabel()
    private let subtitle: UILabel = UILabel()
    private let grade: UILabel = UILabel()
    private let image: UIImageView = UIImageView()
    private let likeButton: UIButton = UIButton()
    
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
        layoutSubTitle()
        layoutGrade()
        layoutImage()
        layoutLikeButton()
    }
    
    private func setComponentsUI() {
        setTitleUI()
        setSubtitleUI()
        setGradeUI()
        setImageUI()
        setLikeButtonUI()
    }
    
    private func layoutTitle() {
        self.contentView.addSubview(title)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            title.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
        ])
        
        
    }
    
    private func layoutSubTitle() {
        self.contentView.addSubview(subtitle)
        
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4),
            subtitle.leadingAnchor.constraint(equalTo: title.leadingAnchor),
        ])
    }
    
    
    private func layoutGrade() {
        self.contentView.addSubview(grade)
        
        grade.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            grade.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: 8),
            grade.leadingAnchor.constraint(equalTo: subtitle.leadingAnchor),
            grade.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant: -8),
        ])
        
        
    }
    
    private func layoutImage() {
        self.contentView.addSubview(image)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            image.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            image.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            image.widthAnchor.constraint(equalTo: image.heightAnchor, multiplier: 0.8)
        ])
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
    }
    
    private func setTitleUI() {
        title.font = .systemFont(ofSize: 16, weight: .semibold)
    }
    
    private func setSubtitleUI() {
        subtitle.font = .systemFont(ofSize: 12, weight: .medium)
        subtitle.textColor = .systemGray4
    }
    
    private func setGradeUI() {
        grade.font = .systemFont(ofSize: 12, weight: .medium)
        grade.textColor = .systemGray4
    }
    
    private func setImageUI() {
        image.backgroundColor = .systemGray4
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        
    }
    
    private func setLikeButtonUI() {
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.tintColor = .white
    }
    
    internal func configureData(_ data: Travel) {
        if let imageUrl = data.travel_image, let url = URL(string: imageUrl) {
            image.kf.setImage(with: url)
        }
        
        title.text = data.title
        subtitle.text = data.description
        grade.text = data.fullGradeDescription
    }
}
