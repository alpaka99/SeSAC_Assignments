//
//  TamagotchiCell.swift
//  TamagotchiProject
//
//  Created by user on 6/7/24.
//

import UIKit

final class TamagotchiCell: UICollectionViewCell {
    let tamagotchiProfile: TGProfileView = TGProfileView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        self.addSubview(tamagotchiProfile)
    }
    
    private func configureLayout() {
        tamagotchiProfile.snp.makeConstraints {
            $0.edges.equalTo(self.snp.edges)
        }
    }
    
    private func configureUI() {
        tamagotchiProfile.profileImage.image = UIImage(named: "noImage")
        tamagotchiProfile.borderdLabel.labelText.text = "준비중이에요"
    }
    
    internal func configureData(_ data: Tamagotchi) {
        tamagotchiProfile.profileImage.image = UIImage(named: data.imageName)
        tamagotchiProfile.borderdLabel.labelText.text = data.name
    }
}

