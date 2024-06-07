//
//  BorderedLabel.swift
//  TamagotchiProject
//
//  Created by user on 6/7/24.
//

import UIKit

import SnapKit

final class TGBorderedLabel: UIView {
    let labelBackground: UIView = UIView()
    let labelText: UILabel = UILabel()
    
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

extension TGBorderedLabel: CodeBaseBuildable {
    internal func configureHierarchy() {
        self.addSubview(labelBackground)
        labelBackground.addSubview(labelText)
    }
    
    internal func configureLayout() {
        labelBackground.snp.makeConstraints {
            $0.edges.equalTo(self.snp.edges)
        }
        
        labelText.snp.makeConstraints {
            $0.edges.equalTo(labelBackground.snp.edges)
                .inset(2)
        }
    }
    
    internal func configureUI() {
        labelBackground.backgroundColor = .clear
        labelBackground.layer.borderColor = UIColor.TGNavyColor.cgColor
        labelBackground.layer.borderWidth = 1
        labelBackground.layer.cornerRadius = 4
        
        labelText.text = "준비중이에요"
        labelText.numberOfLines = 1
        labelText.textAlignment = .center
        labelText.font = .systemFont(ofSize: 12, weight: .semibold)
        labelText.textColor = UIColor.TGNavyColor
    }
}
