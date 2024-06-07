//
//  SettingTableViewCell.swift
//  TamagotchiProject
//
//  Created by user on 6/8/24.
//

import UIKit

import SnapKit

final class SettingTableViewCell: UITableViewCell {
    let icon: UIImageView = UIImageView()
    let title: UILabel = UILabel()
    let trailingSubtitle: UILabel = UILabel()
    let trailingIcon: UIImageView = UIImageView(image: UIImage(systemName: "chevron.right"))

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
            $0.trailing.equalTo(self.accessoryView?.snp.leading ?? self.snp.trailing)
                .offset(-20)
        }
    }
    
    func configureUI() {
        self.backgroundColor = .TGBackgroundColor
        
        icon.image = UIImage(systemName: "pencil")
        
        title.text = "test test test"
        title.numberOfLines = 1
        
        trailingSubtitle.text = "고래밥"
    }
}
