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
    }
    
    private func configureTitle() {
        layoutTitle()
    }
    
    private func configureSubtitle() {
        layoutSubtitle()
    }
    
    private func configureDateLabel() {
        layoutDateLabel()
    }
    
    // background configurations
    private func layoutBackground() {
        
        background.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            background.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            background.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            background.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.9),
            background.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.9)
        ])
        
        background.backgroundColor = .red
        contentView.backgroundColor = .purple
    }
    
    
    
    // cellimage configurations
    private func layoutCellImage() {
        
        cellImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cellImage.topAnchor.constraint(equalTo: background.topAnchor, constant: 8),
            cellImage.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 8),
            cellImage.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: 8),
            cellImage.bottomAnchor.constraint(equalTo: title.topAnchor, constant: -8),
            cellImage.widthAnchor.constraint(equalTo: background.widthAnchor, multiplier: 0.8),
            cellImage.heightAnchor.constraint(equalTo: background.widthAnchor, multiplier: 1),
            
        ])
        
        cellImage.image = UIImage(systemName: "person.fill")
        cellImage.backgroundColor = .green
    }
    
    
    // title configurations
    private func layoutTitle() {
        
        title.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: cellImage.bottomAnchor, constant: -8),
            title.leadingAnchor.constraint(equalTo: cellImage.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: cellImage.trailingAnchor),
            title.bottomAnchor.constraint(equalTo: subtitle.topAnchor, constant: 8)
        ])
        
        title.text = "타이틀타이틀타이틀타이틀"
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
        
        subtitle.text = "서브타이틀서브타이틀서브타이틀서브타이틀"
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
        
        dateLabel.text = String(describing: Date.now)
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
