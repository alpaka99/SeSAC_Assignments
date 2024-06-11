//
//  SearchCollectionCell.swift
//  Day19Assignment
//
//  Created by user on 6/11/24.
//

import UIKit

import SnapKit

final class SearchCollectionViewCell: UICollectionViewCell {
    let posterImage: UIImageView = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension SearchCollectionViewCell: CodeBaseBuildable {
    func configureHierarchy() {
        self.addSubview(posterImage)
    }
    
    func configureLayout() {
        posterImage.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
    }
    
    func configureUI() {
        posterImage.layer.cornerRadius = 8
        posterImage.clipsToBounds = true
        posterImage.contentMode = .scaleToFill
    }
    
    func configureData<T>(_ data: T) {
        
    }
    
    
}
