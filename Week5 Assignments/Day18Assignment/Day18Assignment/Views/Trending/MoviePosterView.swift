//
//  MoviePostView.swift
//  Day18Assignment
//
//  Created by user on 6/10/24.
//

import UIKit

import SnapKit

final class MoviePosterView: UIView {
    let imageView: UIImageView = UIImageView()
    let descriptionView: DescriptionView = DescriptionView()
    
    override internal init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MoviePosterView: CodeBaseBuilldable {
    func configureHierarchy() {
        self.addSubview(imageView)
        imageView.addSubview(descriptionView)
    }
    
    func configureLayout() {
        imageView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
        
        descriptionView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalTo(self)
        }
    }
    
    func configureUI() {
        imageView.backgroundColor = .systemBlue
        
        descriptionView.backgroundColor = .systemOrange
    }
}
