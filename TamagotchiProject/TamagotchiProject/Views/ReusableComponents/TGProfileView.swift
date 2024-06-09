//
//  TamagotchiProfileView.swift
//  TamagotchiProject
//
//  Created by user on 6/7/24.
//

import UIKit

final class TGProfileView: UIView {
    let profileImage: UIImageView = UIImageView()
    let borderdLabel: TGBorderedLabel = TGBorderedLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
    }
}

extension TGProfileView: CodeBaseBuildable {
    internal func configureHierarchy() {
        self.addSubview(profileImage)
        self.addSubview(borderdLabel)
    }
    
    internal func configureLayout() {
        profileImage.snp.makeConstraints {
            $0.size.equalTo(self.snp.width)
                .multipliedBy(0.7)
            $0.top.equalTo(self.safeAreaLayoutGuide)
                .inset(4)
            $0.centerX.equalTo(self.snp.centerX)
        }
        
        borderdLabel.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.bottom)
                .offset(16)
            
            $0.centerX.equalTo(self.snp.centerX)
        }
    }
    
    internal func configureUI() {
        profileImage.layer.borderColor = UIColor.TGNavyColor.cgColor
        profileImage.layer.borderWidth = 2
        profileImage.backgroundColor = .TGBackgroundColor
        profileImage.image = UIImage(named: "noImage")
    }
    
    internal func configureData(_ data: Tamagotchi) {
        print(data.imageName)
        profileImage.image = UIImage(named: data.imageName)
        borderdLabel.configureData(data.name)
    }
}
