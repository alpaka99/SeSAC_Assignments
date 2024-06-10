//
//  CreditHeaderView.swift
//  Day18Assignment
//
//  Created by user on 6/10/24.
//

import UIKit

import SnapKit

final class CreditHeaderView: UIView {
    let backgroundImage: UIImageView = UIImageView()
    let title: UILabel = UILabel()
    let titleImage: UIImageView = UIImageView()
    
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

extension CreditHeaderView: CodeBaseBuilldable {
    func configureHierarchy() {
        self.addSubview(backgroundImage)
        self.addSubview(titleImage)
        self.addSubview(title)
    }
    
    func configureLayout() {
        backgroundImage.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
        
        titleImage.snp.makeConstraints {
            $0.width.equalTo(backgroundImage.snp.width)
                .multipliedBy(0.25)
            $0.height.equalTo(backgroundImage.snp.height)
                .multipliedBy(0.7)
            
            $0.leading.equalTo(backgroundImage.snp.leading)
                .offset(32)
            
            $0.bottom.equalTo(backgroundImage.snp.bottom)
        }
        
        title.snp.makeConstraints {
            $0.leading.equalTo(titleImage.snp.leading)
            $0.bottom.equalTo(titleImage.snp.top)
                .offset(-16)
        }
    }
    
    func configureUI() {
        backgroundImage.backgroundColor = .systemRed
        
        titleImage.backgroundColor = .systemPurple
        
        title.text = "Credit Title"
    }
}
