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
    
    var data = BehaviorSubject(value:[
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
        let original = try! data.value()
        
            searchBar.rx.text.orEmpty
                .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
                .distinctUntilChanged()
                .bind(with: self, onNext: { owner, value in
                    
                    
                    let result = original.filter { $0.title.localizedStandardContains(value)
                    }
////
                    value.isEmpty ?
                    owner.data.onNext(original) : owner.data.onNext(result)

                })
                .disposed(by: disposeBag)
        
        
        data
            .bind(to: tableView.rx.items) { tableView, row, item in
                let cell = tableView.dequeueReusableCell(withIdentifier: AssignmentTableViewCell.identifier) as! AssignmentTableViewCell
                
                cell.isChecked.onNext(item.isChecked)
                cell.title.text = item.title
                cell.isFavorite.onNext(item.isFavorite)
                
                cell.favoriteButton.rx.tap
                    .subscribe {[weak self] _ in
                        var oldValue = try! self?.data.value()
                        oldValue?[row].isFavorite.toggle()
                        
                        self?.data.onNext(oldValue!)
                    }
                    .disposed(by: cell.disposeBag)
                
               cell.checkButton.rx.tap
                    .subscribe {[weak self] _ in
                        var oldValue = try! self?.data.value()
                        oldValue?[row].isChecked.toggle()
                        
                        self?.data.onNext(oldValue!)
                    }
                    .disposed(by: cell.disposeBag)
                
                
                return cell
            }
            .disposed(by: disposeBag)
    }
}

struct CellData {
    var isChecked: Bool
    let title: String
    var isFavorite: Bool
}
