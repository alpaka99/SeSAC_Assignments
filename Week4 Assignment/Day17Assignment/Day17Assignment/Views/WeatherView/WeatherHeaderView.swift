//
//  WeatherHeaderView.swift
//  Day17Assignment
//
//  Created by user on 6/5/24.
//

import UIKit

import SnapKit

final class WeatherHeaderView: UIView {
    let locationButton: UIButton = UIButton()
    let locationLabel: UILabel = UILabel()
    let shareButton: UIButton = UIButton()
    let refreshButton: UIButton = UIButton()
    
    var delegate: WeatherHeaderViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        self.addSubview(locationButton)
        self.addSubview(locationLabel)
        self.addSubview(shareButton)
        self.addSubview(refreshButton)
    }
    
    private func configureLayout() {
        locationButton.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide)
            make.centerY.equalTo(self.snp.centerY)
            make.size.equalTo(self.snp.height)
                .multipliedBy(0.8)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.centerY.equalTo(locationButton.snp.centerY)
            make.leading.equalTo(locationButton.snp.trailing)
                .offset(16)
        }
        
        
        refreshButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.trailing.equalTo(self.snp.trailing)
            make.size.equalTo(self.snp.width)
                .multipliedBy(0.08)
        }
        
        
        shareButton.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.trailing.equalTo(refreshButton.snp.leading)
                .offset(-16)
            make.size.equalTo(refreshButton.snp.size)
            
        }
        
    }
    
    private func configureUI() {
        locationButton.setImage(UIImage(systemName: "location.fill"), for: .normal)
        locationButton.tintColor = .white
        locationButton.addTarget(self, action: #selector(locationButtonTapped), for: .touchUpInside)
        
        
        locationLabel.text = "서울시 노원구 공릉2동"
        locationLabel.textColor = .white
        
        refreshButton.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        refreshButton.tintColor = .white
        refreshButton.addTarget(self, action: #selector(locationButtonTapped), for: .touchUpInside)
        
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.tintColor = .white
        shareButton.addTarget(self, action: #selector(locationButtonTapped), for: .touchUpInside)
    }
    
    
    @objc
    func locationButtonTapped() {
        
    }
}
