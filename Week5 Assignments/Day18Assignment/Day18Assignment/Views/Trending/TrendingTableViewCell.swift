//
//  TrendingTableViewCell.swift
//  Day18Assignment
//
//  Created by user on 6/10/24.
//

import UIKit

import Alamofire
import SnapKit

final class TrendingTableViewCell: UITableViewCell {
    private let dateLabel: UILabel = UILabel()
    private let categoryLabel: UILabel = UILabel()
    private(set) var moviePosterView: MoviePosterView = MoviePosterView()
    var credit: [CreditInfo] = []
    
    weak var delegate: TrendingTableViewCellDelegate?
    
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
        categoryLabel.numberOfLines = 1
        dateLabel.numberOfLines = 1
    }
    
    internal func configureData(_ data: TrendingInfo) {
        categoryLabel.text = Genre.init(rawValue: Int(data.genre_ids.first ?? 0))?.category
        dateLabel.text = data.first_air_date
        fetchCreditData(data)
        moviePosterView.configureData(data)
    }
    
    func fetchCreditData(_ data: TrendingInfo) {
        let parameters: Parameters = [
            "language" : "en-US"
        ]
        
        let headers: HTTPHeaders = [
            "accept" : "application/json",
            "Authorization" : "Bearer \(TMDBKey.accessToken)"
        ]
        
        AF.request(
            "https://api.themoviedb.org/3/tv/\(data.id)/credits",
            parameters: parameters,
            headers: headers
        )
        .responseDecodable(of: CreditResponse.self) { [weak self] response in
            switch response.result {
            case .success(let value):
                print("credit fetch success")
                self?.credit = value.cast
                self?.moviePosterView.creditInfo = value.cast.map { $0.name }
            case .failure(let error):
                print("credit fetch failed")
                print(error)
            }
        }
        
    }
}

protocol TrendingTableViewCellDelegate: AnyObject {
    func fetchCreditInfoFromCell(_ cell: TrendingTableViewCell) -> [CreditInfo]
}
