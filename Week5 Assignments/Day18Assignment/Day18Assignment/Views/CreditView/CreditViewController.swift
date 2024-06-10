//
//  CreditViewController.swift
//  Day18Assignment
//
//  Created by user on 6/10/24.
//

import UIKit

import SnapKit

final class CreditViewController: UIViewController {
    let creditHeaderView: CreditHeaderView = CreditHeaderView()
    let tableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
}

extension CreditViewController: CodeBaseBuilldable {
    func configureHierarchy() {
        view.addSubview(creditHeaderView)
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        creditHeaderView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(view.snp.width)
                .multipliedBy(0.5)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(creditHeaderView.snp.bottom)
                .offset(16)
            
            $0.horizontalEdges.equalTo(view.snp.horizontalEdges)
                .inset(16)
            
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
        tableView.register(CreditOverViewCell.self, forCellReuseIdentifier: CreditOverViewCell.identifier)
        tableView.register(CastViewCell.self, forCellReuseIdentifier: CastViewCell.identifier)
        tableView.backgroundColor = .systemOrange
    }
}

extension CreditViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: // overview section
            return 1
        case 1:
            return 10
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CreditOverViewCell.identifier, for: indexPath) as? CreditOverViewCell else { return UITableViewCell() }
            
            cell.delegate = self
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastViewCell.identifier, for: indexPath) as? CastViewCell else { return UITableViewCell() }
            
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Overview"
        case 1:
            return "Cast"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension CreditViewController: CreditOverViewCellDelegate {
    func dropDownButtonTapped() {
        tableView.reloadData()
    }
}
