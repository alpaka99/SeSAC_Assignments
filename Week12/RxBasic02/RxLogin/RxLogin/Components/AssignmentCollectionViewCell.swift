//
//  AssignmentCollectionViewCell.swift
//  RxLogin
//
//  Created by user on 8/8/24.
//

import UIKit


final class AssignmentCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "AssignmentCollectionViewCell"
    
    let title = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .systemGreen
        label.layer.borderColor = UIColor.systemGreen.cgColor
        label.layer.borderWidth = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    
    @available(iOS, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        contentView.addSubview(title)
        
        title.snp.makeConstraints { label in
            label.edges.equalTo(contentView)
        }
    }
}
