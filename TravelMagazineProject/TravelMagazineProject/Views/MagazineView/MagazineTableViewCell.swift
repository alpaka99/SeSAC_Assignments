//
//  MagazineTableViewCell.swift
//  TravelMagazineProject
//
//  Created by user on 5/26/24.
//

import UIKit

final class MagazineTableViewCell: UITableViewCell {
    internal let background: UIView = UIView()
    internal let cellImage: UIImageView = UIImageView()
    internal let title: UILabel = UILabel()
    internal let subtitle: UILabel = UILabel()
    internal let dateLabel: UILabel = UILabel()
    
    // MARK: 아 이것도 dictionary 마음에 안듬... 어떻게 바꾸는 방법 없나 -> UILabelExtension으로 받아서 바꾸기?
    lazy var labels: [LabelType : UILabel] = [
        .magazineTitle : title,
        .magazineSubtitle : subtitle,
        .magazineDate : dateLabel
    ]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // 이부분에서 cell 초기화
        
        // layout Views
        layoutComponents()
        
        // set components UI
        setComponentsUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutComponents() {
        self.contentView.addSubview(background)
        
        self.background.addSubview(cellImage)
        self.background.addSubview(title)
        self.background.addSubview(subtitle)
        self.background.addSubview(dateLabel)
        
        layoutBackground()
        layoutTitle()
        layoutSubtitle()
        layoutMagazineImage()
        layoutDateLabel()
    }
    
    private func setComponentsUI() {
        setLabels()
        setMagazineImageUI(.magazine)
    }
    
    
    // background configurations
    private func layoutBackground() {
        background.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            background.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            background.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            background.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
            background.heightAnchor.constraint(equalTo: self.contentView.heightAnchor)
        ])
    }
    
    
    
    // cellimage configurations
    private func layoutMagazineImage() {
        cellImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cellImage.topAnchor.constraint(equalTo: background.topAnchor, constant: 8),
            cellImage.centerXAnchor.constraint(equalTo: background.centerXAnchor),
            cellImage.widthAnchor.constraint(equalTo: background.widthAnchor, multiplier: 0.8),
            cellImage.heightAnchor.constraint(equalTo: cellImage.widthAnchor, multiplier: 1),
        ])
    }
    
    // title configurations
    private func layoutTitle() {
        title.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: cellImage.bottomAnchor, constant: 8),
            title.leadingAnchor.constraint(equalTo: cellImage.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: cellImage.trailingAnchor),
        ])
    }
    
    // subtitle configurations
    private func layoutSubtitle() {
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8),
            subtitle.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            subtitle.trailingAnchor.constraint(equalTo: title.trailingAnchor),
        ])
    }
    
    
    // date configurations
    private func layoutDateLabel() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: subtitle.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: subtitle.trailingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -8),
        ])
    }
    
    private func setMagazineImageUI(_ type: ImageViewType) {
        cellImage.layer.cornerRadius = 16
        cellImage.clipsToBounds = true
        cellImage.backgroundColor = .systemGray4
        cellImage.layer.borderColor = UIColor.systemGray4.cgColor
        cellImage.layer.borderWidth = 1
    }
    
    private func setLabels() {
        labels.keys.forEach { type in
            if let label = labels[type] {
                label.numberOfLines = type.numberOfLines
                label.textAlignment = type.textAlignment
                label.font = UIFont.systemFont(ofSize: type.fontSize, weight: type.fontWeight)
                label.textColor = type.textColor
            }
        }
    }
}
