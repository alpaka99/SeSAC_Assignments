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
    
    let switchButton = UISwitch()
    
    let signLabel =  {
        let label  = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    let signName = {
        let textField = UITextField()
        textField.placeholder = "이름을 입력해주세요"
        return textField
    }()
    let signEmail = {
        let textField = UITextField()
        textField.placeholder = "이메일을 입력해주세요"
        return textField
    }()
    let signButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.title = "가입"
        config.background.backgroundColor = .systemBlue
        config.cornerStyle = .capsule
        button.configuration = config
        button.tintColor = .white
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureUI()
        setPickerView()
        setTableView()
        setSwitch()
        setSign()
    }
    

    func configureUI() {
        view.backgroundColor = .white
        
        navigationItem.title = "RxSampleCodes"
        
        view.addSubview(pickerLabel)
        view.addSubview(pickerView)
        view.addSubview(tableLabel)
        view.addSubview(tableView)
        view.addSubview(switchButton)
        view.addSubview(signLabel)
        view.addSubview(signName)
        view.addSubview(signEmail)
        view.addSubview(signButton)
        
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
            tableView.height.equalTo(150)
            
        }
        switchButton.snp.makeConstraints { switchBtn in
            switchBtn.top.equalTo(tableView.snp.bottom)
            switchBtn.centerX.equalToSuperview()
        }
        signLabel.snp.makeConstraints { label in
            label.top.equalTo(switchButton.snp.bottom)
                .offset(8)
            label.horizontalEdges.equalTo(pickerLabel.snp.horizontalEdges)
        }
        signName.snp.makeConstraints { textField in
            textField.top.equalTo(signLabel.snp.bottom)
            textField.leading.equalTo(view.safeAreaLayoutGuide)
            textField.width.equalTo(view.safeAreaLayoutGuide)
                .multipliedBy(0.5)
        }
        signEmail.snp.makeConstraints { textField in
            textField.top.equalTo(signLabel.snp.bottom)
            textField.leading.equalTo(signName.snp.trailing)
            textField.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        signButton.snp.makeConstraints { btn in
            btn.top.equalTo(signName.snp.bottom)
            btn.centerX.equalTo(view.safeAreaLayoutGuide)
            btn.height.equalTo(44)
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
    
    func setSwitch() {
        Observable.of(false) // Observable<Boo> = false를 시작값으로 갖고, 그걸 switch에 넣어줌
            .bind(to: switchButton.rx.isOn)
            .disposed(by: disposeBag)
        
        switchButton.rx.isOn.bind(to: tableView.rx.isHidden)
            .disposed(by: disposeBag)
    }
    
    func setSign() {
        Observable.combineLatest(signName.rx.text.orEmpty, signEmail.rx.text.orEmpty) { name, email in
            return "이름은 \(name)이고, 이메일은 \(email)입니다"
        }
        .bind(to: signLabel.rx.text)
        .disposed(by: disposeBag)
        
        signName.rx.text.orEmpty
            .map { $0.count < 4 }
            .bind(to: signEmail.rx.isHidden, signButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        signEmail.rx.text.orEmpty
            .map { $0.count > 4}
            .bind(to: signButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        signButton.rx.tap
            .subscribe {[weak self] _ in
                self?.showAlert()
            }
            .disposed(by: disposeBag)
    }
    
    private func showAlert() {
        let ac = UIAlertController(title: "알림", message: signLabel.text, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "확인", style: .cancel))
        present(ac, animated: true)
    }
}

