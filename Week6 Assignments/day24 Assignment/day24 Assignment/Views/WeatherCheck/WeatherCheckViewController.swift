//
//  WeatherCheckViewController.swift
//  day24 Assignment
//
//  Created by user on 6/19/24.
//

import UIKit

import SnapKit

final class WeatherCheckViewController: UIViewController {
    let backgroundImage = UIImageView(image: UIImage(named: ImageName.weatherCheckBackgroundImage))

    
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
        
        backgroundImage.addSubview(locationButton)
        backgroundImage.addSubview(locationName)
        backgroundImage.addSubview(shareButton)
        backgroundImage.addSubview(refreshButton)

        backgroundImage.addSubview(tableView)
    }
    
    func configureLayout() {
        backgroundImage.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(backgroundImage)
                .inset(16)
        }
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom)
                .offset(16)
            $0.horizontalEdges.equalTo(timeLabel.snp.horizontalEdges)
        }
        
        locationButton.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom)
                .offset(16)
            $0.leading.equalTo(headerView.snp.leading)
            $0.centerY.equalTo(headerView.snp.centerY)
            $0.size.equalTo(headerView.snp.height)
        }
        
        locationName.snp.makeConstraints {
            $0.leading.equalTo(locationButton.snp.trailing)
                .offset(8)
            $0.centerY.equalTo(headerView.snp.centerY)
            $0.size.equalTo(headerView.snp.height)
        }
        
        refreshButton.snp.makeConstraints {
            $0.trailing.equalTo(headerView.snp.trailing)
                .offset(-8)
            $0.centerY.equalTo(headerView.snp.centerY)
            $0.size.equalTo(headerView.snp.height)
        }
        
        shareButton.snp.makeConstraints {
            $0.trailing.equalTo(refreshButton.snp.leading)
                .offset(-8)
            $0.centerY.equalTo(headerView.snp.centerY)
            $0.size.equalTo(headerView.snp.height)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
                .offset(16)
            $0.horizontalEdges.equalTo(headerView.snp.horizontalEdges)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        backgroundImage.contentMode = .scaleAspectFill
        
        DateHelper.dateFormatter.dateFormat = DateHelper.weatherDateFormat
        timeLabel.text = DateHelper.dateFormatter.string(from: Date.now)
        timeLabel.textColor = .white
        
        print(#function)
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
        
        LocationStore.shared.fetchLocationName()
    }
    
    // MARK: 왜 button에 addTarget이 안되는거지..?
    @objc
    func locationButtonTapped() {
        print(#function)
        LocationStore.shared.fetchLocationName()
    }
    
    @objc
    func shareButtonTapped() {
        print(#function)
    }
}

extension WeatherCheckViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.identifier, for: indexPath) as UITableViewCell
//        cell.textLabel?.text = "졸리다"
        return cell
    }
}
