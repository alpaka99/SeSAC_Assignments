//
//  TGDivider.swift
//  TamagotchiProject
//
//  Created by user on 6/7/24.
//

import UIKit

final class TGDivider: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TGDivider: CodeBaseBuildable {
    func configureHierarchy() {
        
    }
    
    func configureLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(1)
        }
    }
    
    func configureUI() {
        self.backgroundColor = UIColor.TGNavyColor
    }
}
