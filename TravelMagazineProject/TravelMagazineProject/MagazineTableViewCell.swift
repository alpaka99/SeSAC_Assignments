//
//  MagazineTableViewCell.swift
//  TravelMagazineProject
//
//  Created by user on 5/26/24.
//

import UIKit

class MagazineTableViewCell: UITableViewCell, Reusable {
    
    let background: UIView = UIView()
    let cellImage: UIImageView = UIImageView()
    let title: UILabel = UILabel()
    let subtitle: UILabel = UILabel()
    let dateLabel: UILabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // 이부분에서 cell 초기화
        
        self.contentView.addSubview(background)
        
        self.background.addSubview(cellImage)
        self.background.addSubview(title)
        self.background.addSubview(subtitle)
        self.background.addSubview(dateLabel)
        
       
        
        // configure background
        configureBackground()
        
        // configure cell image
        configureCellImage()
        
        // configure titile
        configureTitle()
        
        // configure subTitle
        configureSubtitle()
        
        // configure dateLabel
        configureDateLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureBackground() {
        layoutBackground()
    }
    
    private func configureCellImage() {
        layoutCellImage()
        setCellImageUI()
    }
    
    private func configureTitle() {
        layoutTitle()
        setTitleUI()
    }
    
    private func configureSubtitle() {
        layoutSubtitle()
        setSubtitleUI()
    }
    
    private func configureDateLabel() {
        layoutDateLabel()
        setDateLabelUI()
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
    private func layoutCellImage() {
        cellImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cellImage.topAnchor.constraint(equalTo: background.topAnchor, constant: 8),
            cellImage.centerXAnchor.constraint(equalTo: background.centerXAnchor),            cellImage.bottomAnchor.constraint(equalTo: title.topAnchor, constant: -8),
            cellImage.widthAnchor.constraint(equalTo: background.widthAnchor, multiplier: 0.9),
            cellImage.heightAnchor.constraint(equalTo: cellImage.widthAnchor, multiplier: 1),
        ])
    }
    
    private func setCellImageUI() {
        cellImage.layer.cornerRadius = 12
        cellImage.image = UIImage(systemName: "exclamationmark.arrow.circlepath")
    }
    
    
    // title configurations
    private func layoutTitle() {
        title.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: cellImage.bottomAnchor, constant: -8),
            title.leadingAnchor.constraint(equalTo: cellImage.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: cellImage.trailingAnchor),
            title.bottomAnchor.constraint(equalTo: subtitle.topAnchor, constant: -8)
        ])
    }
    
    private func setTitleUI() {
        title.numberOfLines = 0
        title.textAlignment = .left
        title.font = .systemFont(ofSize: 24, weight: .heavy)
        subtitle.textColor = .black
    }
    
    
    // subtitle configurations
    private func layoutSubtitle() {
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: -8),
            subtitle.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            subtitle.trailingAnchor.constraint(equalTo: title.trailingAnchor),
            subtitle.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -8)
        ])
    }
    
    private func setSubtitleUI() {
        subtitle.numberOfLines = 1
        subtitle.textAlignment = .left
        subtitle.font = .systemFont(ofSize: 16, weight: .bold)
        subtitle.textColor = .systemGray4
    }
    
    // date configurations
    private func layoutDateLabel() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: -8),
            dateLabel.leadingAnchor.constraint(equalTo: subtitle.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: subtitle.trailingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -8),
        ])
    }
    
    private func setDateLabelUI() {
        dateLabel.numberOfLines = 1
        dateLabel.textAlignment = .right
        dateLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        dateLabel.textColor = .systemGray4
    }
}


protocol Reusable {
    static func getReuseIdentifier() -> String
}

extension Reusable {
    static func getReuseIdentifier() -> String {
        return String(describing: Self.self)
    }
}
