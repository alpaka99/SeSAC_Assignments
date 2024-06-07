//
//  WeatherViewController.swift
//  Day17Assignment
//
//  Created by user on 6/5/24.
//

import UIKit

import Alamofire
import SnapKit

final class WeatherViewController: UIViewController {
    let dateLabel: UILabel = UILabel()
    let headerView: WeatherHeaderView = WeatherHeaderView()
    let tableView: UITableView = UITableView()
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    private func configureHierarchy() {
        view.addSubview(dateLabel)
        view.addSubview(headerView)
        view.addSubview(tableView)
    }
    
    private func configureLayout() {
        dateLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
                .inset(16)
        }
        
        headerView.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.top.equalTo(dateLabel.snp.bottom)
                .offset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
                .inset(16)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
                .offset(16)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
                .inset(16)
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .systemOrange
        dateLabel.text = Date.now.description
        
        
        headerView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
    }
}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// WeatherHeaderView Delegate
protocol WeatherHeaderViewDelegate {
    func locationButtonTapped()
    
    func shareButtonTapped()
    
    func refreshButtonTapped()
}

extension WeatherViewController: WeatherHeaderViewDelegate {
    internal func locationButtonTapped() {
        print("location button pressed")
    }
    
    internal func shareButtonTapped() {
        print("share button pressed")
    }
    
    internal func refreshButtonTapped() {
        print("refresh button pressed")
    }
    
    
}
