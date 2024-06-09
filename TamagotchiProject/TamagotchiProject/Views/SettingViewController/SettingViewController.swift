//
//  SettingViewController.swift
//  TamagotchiProject
//
//  Created by user on 6/8/24.
//

import UIKit

import SnapKit

final class SettingViewController: UIViewController {
    let tableView: UITableView = UITableView()
    lazy var settingOptions: [SettingOption] = [
        SettingOption(
            settingType: .changeName,
            icon: "pencil",
            title: "내 이름 설정하기",
            trailingSubtitle: "\(UserNameManager.shared.userName)"
        ),
        SettingOption(
            settingType: .changeTamagotchi,
            icon: "moon.fill",
            title: "다마고치 변경하기",
            trailingSubtitle: nil
        ),
        SettingOption(
            settingType: .resetData,
            icon: "arrow.clockwise",
            title: "데이터 초기화",
            trailingSubtitle: nil
        ),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(userNameChanged), name: NSNotification.Name("UserName"), object: nil)
    }
}

extension SettingViewController: CodeBaseBuildable {
    func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureUI() {
        view.backgroundColor = .TGBackgroundColor
        
        navigationItem.title = "설정"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        
        tableView.backgroundColor = .TGBackgroundColor
    }
}


extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else {
            return UITableViewCell()
        }
        
        let data = settingOptions[indexPath.row]
        cell.configureData(data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SettingTableViewCell {
            doSettingAction(cell.settingType)
        }
    }
    
    func doSettingAction(_ type: SettingType) {
        switch type {
        case .changeName:
            changeNameCellPressed()
        case .changeTamagotchi:
            changeTamagotchiCellPressed()
        case .resetData:
            resetDataCellPressed()
        }
    }
    
    private func changeNameCellPressed() {
        let vc = ChangeNameViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func changeTamagotchiCellPressed() {
        let vc = TamagotchiCollectionViewController()
        vc.collectionViewType = .changeTamagotchi
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func resetDataCellPressed() {
        let ac = UIAlertController(
            title: "데이터 초기화",
            message: "정말 다시 처음부터 시작하실건가용?",
            preferredStyle: .alert
        )
        
        let cancel = UIAlertAction(title: "아냐!", style: .cancel)
        let deleteData = UIAlertAction(title: "웅", style: .default) { _ in
            TamagotchiManager.shared.resetData() { [weak self] in
                self?.navigationController?.popToRootViewController(animated: true)
            }
        }
        
        ac.addAction(cancel)
        ac.addAction(deleteData)
        
        present(ac, animated: true)
    }
    
    @objc
    func userNameChanged() {
        settingOptions[0] = SettingOption(
            settingType: .changeName,
            icon: "pencil",
            title: "내 이름 설정하기",
            trailingSubtitle: "\(UserNameManager.shared.userName)"
        )
        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }
}


extension UITableViewCell: Reusable {
    
}


struct SettingOption {
    let settingType: SettingType
    let icon: String
    let title: String
    let trailingSubtitle: String?
    let trailingIcon: String = "chevron.right"
}


enum SettingType {
    case changeName
    case changeTamagotchi
    case resetData
}
