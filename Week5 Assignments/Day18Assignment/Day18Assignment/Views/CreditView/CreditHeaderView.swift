//
//  CreditHeaderView.swift
//  Day18Assignment
//
//  Created by user on 6/10/24.
//

import UIKit

import Alamofire
import Kingfisher
import SnapKit

final class CreditHeaderView: UIView {
    let backgroundImage: UIImageView = UIImageView()
    let title: UILabel = UILabel()
    let posterImage: UIImageView = UIImageView()
    var backgroundImageData: [ImageInfo] = []
    var posterImageData: [ImageInfo] = []
    
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

extension CreditHeaderView: CodeBaseBuilldable {
    func configureHierarchy() {
        self.addSubview(backgroundImage)
        self.addSubview(posterImage)
        self.addSubview(title)
    }
    
    func configureLayout() {
        backgroundImage.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
        
        posterImage.snp.makeConstraints {
            $0.width.equalTo(backgroundImage.snp.width)
                .multipliedBy(0.25)
            $0.height.equalTo(backgroundImage.snp.height)
                .multipliedBy(0.7)
            
            $0.leading.equalTo(backgroundImage.snp.leading)
                .offset(32)
            
            $0.bottom.equalTo(backgroundImage.snp.bottom)
        }
        
        title.snp.makeConstraints {
            $0.leading.equalTo(posterImage.snp.leading)
            $0.bottom.equalTo(posterImage.snp.top)
                .offset(-16)
        }
    }
    
    func configureUI() {
        backgroundImage.contentMode = .scaleToFill
        backgroundImage.backgroundColor = .black
        
        posterImage.layer.cornerRadius = 8
        posterImage.contentMode = .scaleToFill
        
        title.textColor = .white
        title.font = .systemFont(ofSize: 24, weight: .bold)
    }
    
    func configureData(_ data: TrendingInfo) {
        title.text = data.name
        fetchImages(data)
    }
    
    func fetchImages(_ data: TrendingInfo) {
        let headers: HTTPHeaders = [
            "accept" : "application/json",
            "Authorization" : "Bearer \(TMDBKey.accessToken)"
        ]
        
        let parameters: Parameters = [
            "language" : "en"
        ]
        
        AF.request(
            "https://api.themoviedb.org/3/tv/\(data.id)/images",
            parameters: parameters,
            headers: headers
        )
        .responseDecodable(of: ImageResponse.self) {[weak self] response in
            switch response.result {
            case .success(let value):
                self?.backgroundImageData = value.backdrops
                self?.posterImageData = value.posters
                self?.setImages()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func setImages() {
        if let backgroundImageData = backgroundImageData.first, let url = URL(string: "https://image.tmdb.org/t/p/w500/\(backgroundImageData.file_path)") {
            backgroundImage.kf.setImage(with: url)
        }
        if let posterImageData = posterImageData.first, let url = URL(string: "https://image.tmdb.org/t/p/w500/\(posterImageData.file_path)") {
            print(url)
            posterImage.kf.setImage(with: url)
        }
        
    }
}

struct ImageResponse: Codable {
    let backdrops: [ImageInfo]
    let posters: [ImageInfo]
}

struct ImageInfo: Codable {
    let aspect_ratio: Double
    let height: Int
    let iso_639_1: String
    let file_path: String
    let vote_count: Int
    let width: Int
}
