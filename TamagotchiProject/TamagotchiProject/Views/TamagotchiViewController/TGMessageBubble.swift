//
//  TGMessageBubble.swift
//  TamagotchiProject
//
//  Created by user on 6/8/24.
//

import UIKit

import SnapKit

final class TGMessageBubble: UIView {
    let bubble: UIImageView = UIImageView()
    let message: UILabel = UILabel()
    
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
        layoutIfNeeded()
    }
}

extension TGMessageBubble: CodeBaseBuildable {
    func configureHierarchy() {
        self.addSubview(bubble)
        bubble.addSubview(message)
    }
    
    func configureLayout() {
        bubble.snp.makeConstraints {
            $0.edges.equalTo(self.snp.edges)
        }
        
        message.snp.makeConstraints {
            $0.edges.equalTo(bubble.snp.edges)
                .inset(8)
        }
    }
    
    // MARK: 글자수 많아지면 bubble에서 벗어나는 현상 고치기
    func configureUI() {
        bubble.image = UIImage(named: "bubble")
        bubble.contentMode = .scaleAspectFill
        
        message.numberOfLines = 0
        message.textAlignment = .center
        message.textColor = .TGNavyColor
        message.font = .systemFont(ofSize: 12, weight: .semibold)
        message.text = "복습을 하자 복습을 하자 복습을 열심히 하자 복습을 하자 복습을 하자 복습을 열심히 하자 복습을 하자 복습을 하자 복습을 열심히 하자 복습을 하자 복습을 하자 복습을 열심히 하자 복습을 하자"
    }
    
    
}
