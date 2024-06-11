//
//  SearchCollectionCell.swift
//  Day19Assignment
//
//  Created by user on 6/11/24.
//

import UIKit

import SnapKit

final class SearchCollectionViewCell: UICollectionViewCell {
    var posterImage: UIImageView = UIImageView()
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


extension SearchCollectionViewCell: CodeBaseBuildable {
    func configureHierarchy() {
        contentView.addSubview(posterImage)
    }
    
    func configureLayout() {
        posterImage.snp.makeConstraints {
            $0.edges.equalTo(self.contentView)
        }
    }
    
    func configureUI() {
        posterImage.layer.cornerRadius = 8
        posterImage.clipsToBounds = true
        posterImage.contentMode = .scaleToFill
        posterImage.backgroundColor = .systemOrange
    }
    
    func configureData<T>(_ data: T) {
        guard let data = data as? SearchData else { return }
        SearchManager.shared.fetchImageById(id: data.id) {[weak self] filePath in
            if let filePath = filePath {
                SearchManager.shared.fetchImage(filePath) { image in
                    self?.posterImage.image = image
                }
            } else {
                self?.posterImage.image = UIImage(systemName: "camera.fill")
            }
        }
    }
}
