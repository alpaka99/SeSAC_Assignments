//
//  TamagotchiProfileView.swift
//  TamagotchiProject
//
//  Created by user on 6/7/24.
//

import UIKit

final class TamagotchiProfileView: UIView {
    let profileImage: UIImageView = UIImageView()
//    let nameBackground: UIView = UIView()
//    let name: UILabel = UILabel()
    let borderdLabel: BorderedLabel = BorderedLabel()
    
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

extension TamagotchiProfileView: CodeBaseBuildable {
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
                .offset(4)
            
            $0.centerX.equalTo(self.snp.centerX)
            
            $0.bottom.equalTo(self.snp.bottom)
                .offset(-4)
        }
    }
    
    internal func configureUI() {
        profileImage.clipsToBounds = true
        profileImage.layer.borderColor = UIColor.black.cgColor
        profileImage.layer.borderWidth = 1
    }
}
