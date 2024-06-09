//
//  SettingTableViewCell.swift
//  TamagotchiProject
//
//  Created by user on 6/8/24.
//

import UIKit

import SnapKit

final class SettingTableViewCell: UITableViewCell {
    var settingType: SettingType = .changeName
    let icon: UIImageView = UIImageView()
    let title: UILabel = UILabel()
    let trailingSubtitle: UILabel = UILabel()
    let trailingIcon: UIImageView = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension SettingTableViewCell: CodeBaseBuildable {
    func configureHierarchy() {
        self.addSubview(icon)
        self.addSubview(title)
        self.addSubview(trailingSubtitle)
        self.addSubview(trailingIcon)
        self.accessoryView = trailingIcon
    }
    
    func configureLayout() {
        icon.snp.makeConstraints {
            $0.leading.equalTo(self.snp.leading)
                .offset(16)
            $0.centerY.equalTo(self.snp.centerY)
        }
        
        title.snp.makeConstraints {
            $0.leading.equalTo(icon.snp.trailing)
                .offset(8)
            $0.centerY.equalTo(self.snp.centerY)
        }
        
        trailingSubtitle.snp.makeConstraints {
            $0.centerY.equalTo(self.snp.centerY)
            $0.trailing.equalTo(self.trailingIcon.snp.leading)
                .offset(-20)
        }
        
        trailingIcon.snp.makeConstraints {
            $0.centerY.equalTo(self.snp.centerY)
            $0.trailing.equalTo(self.snp.trailing)
                .offset(-8)
        }
    }
    
    func configureUI() {
        self.backgroundColor = .TGBackgroundColor
        
        title.numberOfLines = 1
    }
    
    func configureData(_ data: SettingOption) {
        settingType = data.settingType
        icon.image = UIImage(systemName: data.icon)
        
        title.text = data.title
        
        trailingSubtitle.text = data.trailingSubtitle
        
        trailingIcon.image = UIImage(systemName: data.trailingIcon)
    }
}
