//
//  DescriptionView.swift
//  Day18Assignment
//
//  Created by user on 6/10/24.
//

import UIKit

import SnapKit

final class DescriptionView: UIView {
    let background: UIView = UIView()
    var title: UILabel = UILabel()
    var subtitle: UILabel = UILabel()
    let divider: UIView = UIView()
    let detailLabel: UILabel = UILabel()
    let disclosureButton: UIButton = UIButton()
    
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


extension DescriptionView: CodeBaseBuilldable {
    func configureHierarchy() {
        self.addSubview(background)
        background.addSubview(title)
        background.addSubview(subtitle)
        background.addSubview(divider)
        background.addSubview(detailLabel)
        background.addSubview(disclosureButton)
    }
    
    func configureLayout() {
        background.snp.makeConstraints {
            $0.edges.equalTo(self.snp.edges)
        }
        
        title.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(background)
                .inset(16)
        }
        
        subtitle.snp.makeConstraints {
            $0.leading.trailing.equalTo(title)
            $0.top.equalTo(title.snp.bottom)
                .offset(8)
        }
        
        divider.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.trailing.equalTo(title)
            $0.top.equalTo(subtitle.snp.bottom)
                .offset(16)
        }
        
        detailLabel.snp.makeConstraints {
            $0.leading.equalTo(divider.snp.leading)
            $0.top.equalTo(divider.snp.bottom)
                .offset(16)
            $0.bottom.equalTo(background.snp.bottom)
                .offset(-8)
        }
        
        disclosureButton.snp.makeConstraints {
            $0.verticalEdges.equalTo(detailLabel.snp.verticalEdges)
            $0.trailing.equalTo(background.snp.trailing)
        }
    }
    
    func configureUI() {
        background.backgroundColor = .white
        
        title.text = "Title Title Title  Title "
        title.numberOfLines = 1
        subtitle.text = "Subtitle  Subtitle  Subtitle "
        subtitle.numberOfLines = 1
        
        divider.backgroundColor = .black
        
        detailLabel.text = "자세히보기"
        disclosureButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
    }
    
    
}
