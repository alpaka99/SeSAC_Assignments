//
//  ViewController.swift
//  Day18Assignment
//
//  Created by user on 6/10/24.
//

import UIKit

import Alamofire
import SnapKit

final class TrendingViewController: UIViewController {
    private let tableView: UITableView = UITableView()
    private let leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: TrendingViewController.self, action: #selector(leftBarButtonItemTapped))
    private let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: TrendingViewController.self, action: #selector(rightBarButtonItemTapped))
    
    private var trendingInfo: [TrendingInfo] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override internal func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureHierarchy()
        configureLayout()
        configureUI()
        
        fetchMovieData()
    }
}



extension TrendingViewController: CodeBaseBuilldable {
    internal func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    internal func configureLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    internal func configureUI() {
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
        tableView.register(TrendingTableViewCell.self, forCellReuseIdentifier: TrendingTableViewCell.identifier)
    }
    
    private func fetchMovieData() {
        let headers: HTTPHeaders = [
            "accept" : "application/json",
            "Authorization" : "Bearer \(TMDBKey.accessToken)"
        ]
        
        let parameters: Parameters = [
            "language" : "en-US",
        ]
        
        AF.request(
            "https://api.themoviedb.org/3/trending/tv/week",
            parameters: parameters,
            headers: headers
        )
        .responseDecodable(of: TrendingResponse.self) { [weak self] response in
            switch response.result {
            case .success(let value):
                print("Success")
                self?.trendingInfo = value.results
            case .failure(let error):
                print("Failure")
                print(error)
            }
        }
    }
    
    @objc
    private func leftBarButtonItemTapped(_ sender: UIBarButtonItem) {
        print(#function)
    }
    
    @objc
    private func rightBarButtonItemTapped(_ sender: UIBarButtonItem) {
        print(#function)
    }
}

extension TrendingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trendingInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendingTableViewCell.identifier, for: indexPath) as? TrendingTableViewCell else { return UITableViewCell() }
        
        let data = trendingInfo[indexPath.row]
        cell.configureData(data)
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? TrendingTableViewCell {
            print(fetchCreditInfoFromCell(cell))
            let vc = CreditViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension TrendingViewController: TrendingTableViewCellDelegate {
    func fetchCreditInfoFromCell(_ cell: TrendingTableViewCell) -> [CreditInfo] {
        return cell.credit
    }
}


//https://developer.themoviedb.org/reference/movie-top-rated-list

//https://developer.themoviedb.org/reference/tv-series-images






