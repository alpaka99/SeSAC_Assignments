//
//  MovieRankingCell.swift
//  Day17Assignment
//
//  Created by user on 6/5/24.
//

import UIKit

import SnapKit

final class MovieRankingCell: UITableViewCell {
    
    let ranking: UILabel = UILabel()
    let movieTitle: UILabel = UILabel()
    let releaseDate: UILabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureHierarchy() {
        contentView.addSubview(ranking)
        contentView.addSubview(movieTitle)
        contentView.addSubview(releaseDate)
    }
    
    private func configureLayout() {
        ranking.snp.makeConstraints { make in
            make.leading.equalTo(contentView)
            make.verticalEdges.equalTo(contentView)
                .inset(8)
            make.width.equalTo(contentView.snp.width)
                .multipliedBy(0.1)
        }
        
        movieTitle.snp.makeConstraints { make in
            make.leading.equalTo(ranking.snp.trailing)
                .offset(16)
            make.verticalEdges.equalTo(ranking.snp.verticalEdges)
        }
        
        releaseDate.snp.makeConstraints { make in
            make.leading.equalTo(movieTitle.snp.trailing)
                .offset(16)
            make.centerY.equalTo(movieTitle.snp.centerY)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    private func configureUI() {
        ranking.backgroundColor = .white
        ranking.text = "20"
        ranking.textAlignment = .center
        ranking.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        movieTitle.text = "더퍼스트슬램덩크"
        movieTitle.numberOfLines = 1
        movieTitle.textColor = .white
        movieTitle.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        releaseDate.text = "\(Date.now.formatted())"
        releaseDate.textColor = .white
        releaseDate.textAlignment = .right
        
        self.backgroundColor = .clear
    }
    
}
