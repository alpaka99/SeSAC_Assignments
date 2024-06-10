//
//  MoviePostView.swift
//  Day18Assignment
//
//  Created by user on 6/10/24.
//

import Foundation
import UIKit

import Alamofire
import Kingfisher
import SnapKit

final class MoviePosterView: UIView {
    let imageView: UIImageView = UIImageView()
    let descriptionView: DescriptionView = DescriptionView()
    var creditInfo: [String] = []
    
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
        self.layer.borderColor = UIColor.systemGray.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        
        imageView.backgroundColor = .systemBlue
        imageView.contentMode = .scaleToFill
        
        descriptionView.backgroundColor = .systemOrange
    }
    
    func configureData(_ data: TrendingInfo) {
        if let url = URL(string: "https://image.tmdb.org/t/p/w500/\(data.backdrop_path)") {
            imageView.kf.setImage(with: url)
        }
        
        descriptionView.configureData(data)
        descriptionView.detailLabel.text = creditInfo.joined(separator: " ")
    }
}
