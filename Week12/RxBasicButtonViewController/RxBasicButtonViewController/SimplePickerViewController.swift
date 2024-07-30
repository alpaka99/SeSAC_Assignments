//
//  ViewController.swift
//  RxBasicButtonViewController
//
//  Created by user on 7/30/24.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

class SimplePickerViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let pickerView1 = UIPickerView()
    let pickerView2 = UIPickerView()
    let pickerView3 = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        configureUI()
        configureRx()
        
    }
    
    func configureUI() {
        view.backgroundColor = .white
        view.addSubview(pickerView1)
        view.addSubview(pickerView2)
        view.addSubview(pickerView3)
        
        pickerView1.snp.makeConstraints { pickerView in
            pickerView.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        pickerView2.snp.makeConstraints { pickerView in
            pickerView.top.equalTo(pickerView1.snp.bottom)
            pickerView.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        pickerView3.snp.makeConstraints { pickerView in
            pickerView.top.equalTo(pickerView2.snp.bottom)
            pickerView.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
    func configureRx() {
        Observable.just([1, 2, 3])
            .bind(to: pickerView1.rx.itemTitles) { _ , item in
                return String(describing: item)
            }
            .disposed(by: disposeBag)
        
        pickerView1.rx.modelSelected(Int.self)
            .subscribe { item in
                print("\(item)이 선택되었습니다")
            }
            .disposed(by: disposeBag)
        
        Observable.just([1, 2, 3])
            .bind(to: pickerView2.rx.itemAttributedTitles) { _, item in
                
                return NSAttributedString(string: "\(item) item",
                                          attributes: [
                                            NSAttributedString.Key.foregroundColor: UIColor.systemBlue,
                                            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.double.rawValue
                                        ])
            }
            .disposed(by: disposeBag)
        
        pickerView2.rx.modelSelected(Int.self)
            .subscribe { item in
                print("\(item)이 선택되었네오?")
            }
            .disposed(by: disposeBag)
        
        Observable.just([UIColor.systemOrange, UIColor.systemBlue, UIColor.systemIndigo])
            .bind(to: pickerView3.rx.items) { _, item, _ in
                let view = UIView()
                view.backgroundColor = item
                return view
            }
            .disposed(by: disposeBag)
        
        pickerView3.rx.modelSelected(UIColor.self)
            .subscribe { item in
                print("\(item)맛이 나!")
            }
            .disposed(by: disposeBag)
    }
}

