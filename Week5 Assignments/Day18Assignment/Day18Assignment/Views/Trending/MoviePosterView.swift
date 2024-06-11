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
    var creditInfo: [String] = [] {
        didSet {
            configureUI()
        }
    }
    
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
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.layer.masksToBounds = false
        
        
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.systemGray.cgColor
        imageView.layer.borderWidth = 1
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
