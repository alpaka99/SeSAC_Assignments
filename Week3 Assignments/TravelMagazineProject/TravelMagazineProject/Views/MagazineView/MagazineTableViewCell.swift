//
//  MagazineTableViewCell.swift
//  TravelMagazineProject
//
//  Created by user on 5/26/24.
//

import UIKit

final class MagazineTableViewCell: UITableViewCell, BackgroundBuildable, LabelBuildable, ImageViewBuildable {
    internal let background: UIView = UIView()
    
    lazy var backgrounds: [BackgroundType : UIView] = [:]
    
    internal let title: UILabel = UILabel()
    internal let subtitle: UILabel = UILabel()
    internal let dateLabel: UILabel = UILabel()
    
    // MARK: 더 깔끔하게 바꿀 수 있는 방법 생각하기
    lazy var labels: [LabelType : UILabel] = [
        .magazineTitle : title,
        .magazineSubtitle : subtitle,
        .magazineDate : dateLabel
    ]
    
    internal let magazineImage: UIImageView = UIImageView()
    
    lazy var imageViews: [ImageViewType : UIImageView] = [ .magazine : magazineImage ]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // 이부분에서 cell 초기화
        
        // layout Views
        layoutComponents()
        
        // set components UI
        buildUIs()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutComponents() {
        self.contentView.addSubview(background)
        
        self.background.addSubview(magazineImage)
        self.background.addSubview(title)
        self.background.addSubview(subtitle)
        self.background.addSubview(dateLabel)
        
        layoutBackground()
        layoutTitle()
        layoutSubtitle()
        layoutMagazineImage()
        layoutDateLabel()
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
        magazineImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            magazineImage.topAnchor.constraint(equalTo: background.topAnchor, constant: 8),
            magazineImage.centerXAnchor.constraint(equalTo: background.centerXAnchor),
            magazineImage.widthAnchor.constraint(equalTo: background.widthAnchor, multiplier: 0.8),
            magazineImage.heightAnchor.constraint(equalTo: magazineImage.widthAnchor, multiplier: 1),
        ])
    }
    
    // title configurations
    private func layoutTitle() {
        title.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: magazineImage.bottomAnchor, constant: 8),
            title.leadingAnchor.constraint(equalTo: magazineImage.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: magazineImage.trailingAnchor),
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
    
    private func buildUIs() {
        buildBackgroundsUI()
        buildLabelsUI()
        buildImageViewsUI()
    }
}
