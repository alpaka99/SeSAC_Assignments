//
//  TrendingTableViewCell.swift
//  Day18Assignment
//
//  Created by user on 6/10/24.
//

import UIKit

import SnapKit

final class TrendingTableViewCell: UITableViewCell {
    private let dateLabel: UILabel = UILabel()
    private let categoryLabel: UILabel = UILabel()
    private let moviePosterView: MoviePosterView = MoviePosterView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TrendingTableViewCell: CodeBaseBuilldable {
    internal func configureHierarchy() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(moviePosterView)
    }
    
    internal func configureLayout() {
        moviePosterView.snp.makeConstraints {
            $0.width.equalTo(contentView.snp.width)
                .multipliedBy(0.8)
            $0.height.equalTo(moviePosterView.snp.width)
                .multipliedBy(1)
            $0.bottom.equalTo(contentView.snp.bottom)
                .offset(-8)
            $0.centerX.equalTo(contentView.snp.centerX)
        }
        
        categoryLabel.snp.makeConstraints {
            $0.horizontalEdges.equalTo(moviePosterView.snp.horizontalEdges)
            $0.bottom.equalTo(moviePosterView.snp.top)
                .offset(-8)
        }
        
        dateLabel.snp.makeConstraints {
            $0.horizontalEdges.equalTo(categoryLabel.snp.horizontalEdges)
            $0.bottom.equalTo(categoryLabel.snp.top)
                .offset(-8)
            $0.top.equalTo(contentView.snp.top)
                .offset(8)
        }
    }
    
    internal func configureUI() {
        categoryLabel.text = "#Category"
        categoryLabel.numberOfLines = 1
        
        dateLabel.text = String(describing: Date.now.formatted())
        dateLabel.numberOfLines = 1
    }
}
