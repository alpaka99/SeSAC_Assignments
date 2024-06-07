//
//  TamagotchiCell.swift
//  TamagotchiProject
//
//  Created by user on 6/7/24.
//

import UIKit

final class TamagotchiCell: UICollectionViewCell {
    let tamagotchiProfile:TamagotchiProfileView = TamagotchiProfileView()
    
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
        
    }
}

