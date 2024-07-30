//
//  ViewController.swift
//  RxSampleCodes
//
//  Created by user on 7/31/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

class ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let pickerLabel = {
        let label  = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    let pickerView = UIPickerView()
    
    let tableLabel = {
        let label  = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureUI()
        setPickerView()
        setTableView()
    }
    

    func configureUI() {
        view.backgroundColor = .white
        
        navigationItem.title = "RxSampleCodes"
        
        view.addSubview(pickerLabel)
        view.addSubview(pickerView)
        view.addSubview(tableLabel)
        view.addSubview(tableView)
        
        pickerLabel.snp.makeConstraints { label in
            label.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
                .inset(8)
        }
        pickerView.snp.makeConstraints { picker in
            picker.top.equalTo(pickerLabel.snp.bottom)
            picker.horizontalEdges.equalTo(view.snp.horizontalEdges)
                .inset(8)
        }
        tableLabel.snp.makeConstraints { label in
            label.top.equalTo(pickerView.snp.bottom)
            label.horizontalEdges.equalTo(pickerLabel)
        }
        tableView.snp.makeConstraints { tableView in
            tableView.top.equalTo(tableLabel.snp.bottom)
                .offset(8)
            tableView.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
                .inset(8)
            tableView.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    func setPickerView() {
        /*
         단순한 타입도 Observable.just() 등을 통해 element를 Observable로 만들어줄 수 있다.
         items의 타입으로 보면 Observable<[String]>임
         */
        let items = Observable.just([
            "파도혁명",
            "월담소녀",
            "희비교차",
            "푸름애"
        ])
            
        /*
         Observable객체(이벤트를 발생시킬 수 있는 객체)를 bind를 통해서 이벤트를 핸들링함
         */
        items.bind(to: pickerView.rx.itemTitles) { _, item in
            return "\(item)"
        }
        .disposed(by: disposeBag)
        
        /*
         이제는 pickerView의 modelSelected 이벤트를 subscribe
         pickerView도 이벤트를 발생시킬 수 있는 observable 객체임
         
         Q: 근데 bind는 초기에 1번은 bind해주는 actionBind 같은건 없나?
         */
        pickerView.rx.modelSelected(String.self)
//            .subscribe(onNext:  { models in
//                print("현재 재생하고 있는 음악은 \(models)입니다")
//            })
            .map { "현재 재생하고 있는 음악은 \($0)입니다" }
            .bind(to: pickerLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    func setTableView() {
        let items = Observable.just([
            "낮에 뜨는 달",
            "홍연",
            "상사화",
            "달그림자"
        ])
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        
        items
            .bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")!
            cell.textLabel?.text = element
            return cell
        }
        .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self)
            .map { 
                "\($0)를 탭했습니다"
            }
            .bind(to: tableLabel.rx.text)
            .disposed(by: disposeBag)
    }
}

