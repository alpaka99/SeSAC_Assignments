//
//  SimpleTableViewController.swift
//  RxBasicButtonViewController
//
//  Created by user on 7/31/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class SimpleTableViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureRx()
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { tableView in
            tableView.edges.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func configureRx() {
        Observable.just(
            (0..<20)
            .map{"\($0)"}
        )
        .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) {
            (row, element, cell) in
            cell.textLabel?.text = element + "번째 cell"
        }
        .disposed(by: disposeBag)
        
        
        tableView.rx
            .modelSelected(String.self)
            .subscribe(onNext: {[weak self] selectedRow in
                self?.showaAlert(selectedRow)
            })
            .disposed(by: disposeBag)
    }
    
    func showaAlert(_ selectedRow: String) {
        let ac = UIAlertController(title: "TableViewAlert", message: "Tapped \(selectedRow)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(ac, animated: true)
    }
}
