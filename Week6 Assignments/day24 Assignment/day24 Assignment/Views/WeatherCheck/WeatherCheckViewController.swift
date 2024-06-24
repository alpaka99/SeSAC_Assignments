//
//  WeatherCheckViewController.swift
//  day24 Assignment
//
//  Created by user on 6/19/24.
//

import UIKit

import SnapKit

final class WeatherCheckViewController: UIViewController {
    let backgroundImage = UIImageView()
    
    let timeLabel = UILabel()
    
    let headerView = UIView()
    let locationButton = UIButton()
        .image(systemName: ImageName.locationImage)
        .adjustSystemImageSize(size: 24)
        .tintColor(with: .white)
        .backgroundColor(with: .systemOrange)
    let locationName = UILabel()
    let shareButton = UIButton()
        .image(systemName: ImageName.shareImage)
        .tintColor(with: .white)
    let refreshButton = UIButton()
        .image(systemName: ImageName.refreshImage)
        .tintColor(with: .white)
    
    let tableView = UITableView()
    
    let testButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    func configureHierarchy() {
        view.addSubview(backgroundImage)
        
        backgroundImage.addSubview(timeLabel)
        
        backgroundImage.addSubview(headerView)
//        
        headerView.addSubview(locationButton)
        headerView.addSubview(locationName)
        headerView.addSubview(shareButton)
        headerView.addSubview(refreshButton)
        
//        backgroundImage.addSubview(locationButton)
//        backgroundImage.addSubview(locationName)
//        backgroundImage.addSubview(shareButton)
//        backgroundImage.addSubview(refreshButton)

        backgroundImage.addSubview(tableView)
        
        backgroundImage.addSubview(testButton)
    }
    
    func configureLayout() {
        backgroundImage.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(backgroundImage)
                .inset(16)
        }
        
//        headerView.snp.makeConstraints {
//            $0.top.equalTo(timeLabel.snp.bottom)
//                .offset(16)
//            $0.horizontalEdges.equalTo(timeLabel.snp.horizontalEdges)
//        }
//        
        locationButton.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom)
                .offset(16)
            $0.leading.equalTo(timeLabel.snp.leading)
            $0.size.equalTo(44)
        }
        
        locationName.snp.makeConstraints {
            $0.leading.equalTo(locationButton.snp.trailing)
                .offset(8)
            $0.centerY.equalTo(locationButton.snp.centerY)
            $0.size.equalTo(locationButton.snp.height)
        }
        
        refreshButton.snp.makeConstraints {
            $0.trailing.equalTo(timeLabel.snp.trailing)
                .offset(-8)
            $0.centerY.equalTo(locationButton.snp.centerY)
            $0.size.equalTo(locationButton.snp.height)
        }
        
        shareButton.snp.makeConstraints {
            $0.trailing.equalTo(refreshButton.snp.leading)
                .offset(-8)
            $0.centerY.equalTo(locationButton.snp.centerY)
            $0.size.equalTo(locationButton.snp.height)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(locationButton.snp.bottom)
                .offset(16)
            $0.horizontalEdges.equalTo(timeLabel.snp.horizontalEdges)
//            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        testButton.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.bottom)
            
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
//        backgroundImage.image = UIImage(named: ImageName.weatherCheckBackgroundImage)
        backgroundImage.contentMode = .scaleAspectFill
        
        DateHelper.dateFormatter.dateFormat = DateHelper.weatherDateFormat
        timeLabel.text = DateHelper.dateFormatter.string(from: Date.now)
        timeLabel.textColor = .white
        
        locationName.text = "위치 이름"
        locationName.textColor = .white
        
        locationButton.addTarget(
            self,
            action: #selector(locationButtonTapped),
            for: .touchUpInside
        )
        
        shareButton.addTarget(
            self,
            action: #selector(shareButtonTapped),
            for: .touchUpInside
        )
        
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: UITableViewCell.identifier
        )
        tableView.backgroundColor = .clear
        
        print(#function)
        testButton.addTarget(self, action: #selector(locationButtonTapped), for: .touchUpInside)
        testButton.backgroundColor = .systemOrange
        testButton.tintColor = .white
        testButton.setTitle("TestButton", for: .normal)
        
//        LocationStore.shared.fetchLocationName()
    }
    
    // MARK: 왜 button에 addTarget이 안되는거지..?
    @objc
    func locationButtonTapped() {
        print(#function)
        LocationStore.shared.fetchLocationName()
    }
    
    @objc
    func shareButtonTapped(_ sender: UIButton) {
        print(#function)
    }
}

extension WeatherCheckViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.identifier, for: indexPath) as UITableViewCell
        return cell
    }
}
