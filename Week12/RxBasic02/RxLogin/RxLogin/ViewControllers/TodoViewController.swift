//
//  TodoViewController.swift
//  RxLogin
//
//  Created by user on 8/4/24.
//

import UIKit

import SnapKit
import RxCocoa
import RxSwift

final class TodoViewController: UIViewController {
    let searchBar = UISearchBar()
    let tableView = UITableView()
    
    let disposeBag = DisposeBag()
    
    var data = BehaviorRelay(value:[
        CellData(isChecked: false, title: "first", isFavorite: true),
        CellData(isChecked: true, title: "second", isFavorite: false),
        CellData(isChecked: true, title: "third", isFavorite: true),
        CellData(isChecked: false, title: "fourth", isFavorite: false),
        CellData(isChecked: true, title: "fifth", isFavorite: false),
    ])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureBind()
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        searchBar.snp.makeConstraints { searchBar in
            searchBar.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
                .inset(16)
        }
        
        tableView.snp.makeConstraints { tableView in
            tableView.top.equalTo(searchBar.snp.bottom)
                .offset(20)
            tableView.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
                .inset(16)
            tableView.bottom.equalTo(view.safeAreaLayoutGuide)
                .inset(16)
        }
        
        tableView.register(AssignmentTableViewCell
            .self, forCellReuseIdentifier: AssignmentTableViewCell.identifier)
    }
    
    func configureBind() {
        // ?? 왜 searchBar에 bind를 하니까 tap이 안되지?
        let original = data.value
        
        searchBar.rx.text.orEmpty
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind(with: self, onNext: { owner, value in
                let result = original.filter { $0.title.localizedStandardContains(value)
                }
                
                value.isEmpty ?
                owner.data.accept(original)
                : owner.data.accept(result)

            })
            .disposed(by: disposeBag)
        
        
        data
            .bind(to: tableView.rx.items(cellIdentifier: AssignmentTableViewCell.identifier, cellType: AssignmentTableViewCell.self)) { row, item, cell in
                
                cell.configureData(cellData: item)
                
                cell.checkButton.rx.tap
                    .bind(with: self, onNext: { owner, _ in
                        var list = owner.data.value
                        list[row].isChecked.toggle()
                        owner.data.accept(list)
                    })
                    .disposed(by: cell.disposeBag)
                
               cell.favoriteButton.rx.tap
                    .bind(with: self, onNext: { owner, _ in
                        var list = owner.data.value
                        list[row].isFavorite.toggle()
                        owner.data.accept(list)
                    })
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .bind(with: self) { owner, indexPath in
                let vc = UIViewController()
                vc.view.backgroundColor = .systemIndigo
                
                owner.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
    }
}

struct CellData {
    var isChecked: Bool
    let title: String
    var isFavorite: Bool
}
