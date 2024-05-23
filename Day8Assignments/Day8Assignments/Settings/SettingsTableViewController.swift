//
//  SettingsTableViewController.swift
//  Day8Assignments
//
//  Created by user on 5/23/24.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    private let settingsTableViewControllerData: [HeaderType: [SettingsCellType]] = [
        .commonSettings : [
            .defaultType("공지사항"),
            .defaultType("실험실"),
            .defaultType("버전 정보"),
        ],
        .privateSettings : [
            .defaultType("개인/보안"),
            .defaultType("알림"),
            .defaultType("채팅"),
            .defaultType("멀티프로필")
        ],
        .others: [
            .defaultType("고객센터/도움말")
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return HeaderType.getHeaderType(section).title
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HeaderType.allCases[section].numberOfRowsInSection
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as UITableViewCell
        
        if let cells = settingsTableViewControllerData[HeaderType.getHeaderType(indexPath.section)] {
            let cellData = cells[indexPath.row]
            
            cell.textLabel?.text = cellData.title
            cell.textLabel?.font = cellData.font
            cell.textLabel?.textColor = cellData.textColor
            cell.accessoryType = cellData.accessoryType
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let headerType = HeaderType.getHeaderType(indexPath.section)
        if let cells = settingsTableViewControllerData[headerType] {
            let selectedCell = cells[indexPath.row]
            
            if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
                
                detailViewController.title = selectedCell.title
                detailViewController.textLabel.text = "\(selectedCell.title)이 서비스 준비중이에요🛠️"
                detailViewController.textLabel.textAlignment = .center
                
                detailViewController.view.backgroundColor = UIColor(
                    red: CGFloat.random(in: 0...1),
                    green: CGFloat.random(in: 0...1),
                    blue: CGFloat.random(in: 0...1),
                    alpha: 1
                )
                
                navigationController?.pushViewController(detailViewController, animated: true)
            }
        }
    }
}

private enum HeaderType: CaseIterable {
    // for .allCases to be in same order everytime and remove unknown case
    static var allCases: [HeaderType] = [
        commonSettings,
        privateSettings,
        others
    ]
    
    case commonSettings
    case privateSettings
    case others
    case unknown
    
    var title: String {
        switch self {
        case .commonSettings:
            return "전체 설정"
        case .privateSettings:
            return "개인 설정"
        case .others:
            return "기타"
        case .unknown:
            return "unknown"
        }
    }
    
    var numberOfRowsInSection: Int {
        switch self {
        case .commonSettings:
            return 3
        case .privateSettings:
            return 4
        case .others:
            return 1
        case .unknown:
            return 2
        }
    }
    
    static func getHeaderType(_ number: Int) -> Self {
        switch number {
        case 0:
            return .commonSettings
        case 1:
            return .privateSettings
        case 2:
            return .others
        default:
            return .unknown
        }
    }
    
    var color: UIColor {
        switch self {
        case .commonSettings:
            return .gray
        case .privateSettings:
            return .gray
        case .others:
            return .gray
        case .unknown:
            return .clear
        }
    }
    
    var font: UIFont {
        switch self {
            
        case .commonSettings:
            return UIFont.systemFont(
                ofSize: 24,
                weight: .medium
            )
        case .privateSettings:
            return UIFont.systemFont(
                ofSize: 24,
                weight: .medium
            )
        case .others:
            return UIFont.systemFont(
                ofSize: 24,
                weight: .medium
            )
        case .unknown:
            return UIFont.systemFont(
                ofSize: 24,
                weight: .medium
            )
        }
    }
}

private enum SettingsCellType {
    case defaultType(String)
    
    var title: String {
        switch self {
        case .defaultType(let title):
            return title
        }
    }
    
    var font: UIFont {
        switch self {
        case .defaultType(_):
            return UIFont.systemFont(
                ofSize: 12,
                weight: .regular
            )
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .defaultType(_):
            return .lightGray
        }
    }
    
    var accessoryType: UITableViewCell.AccessoryType {
        switch self {
        case .defaultType(_):
            return .none
        }
    }
}
