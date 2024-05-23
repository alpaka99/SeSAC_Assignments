//
//  FocusTableViewController.swift
//  Day8Assignments
//
//  Created by user on 5/23/24.
//

import UIKit

final class FocusTableViewController: UITableViewController {
    
    let customCellReuseIdentifier: String = "CustomCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // custom cell register
        self.tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.cellId)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "header"
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "footer"
    }
    
    // 1. cell 몇개 만들지
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    // 2. 만든 cell의 높이는 몇으로 할지
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45 // MARK: 이 부분을 dynamic하게 맞추는 방법 없을까 흠..
    }
    
    // 3. cell 정보 담기
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.cellId, for: indexPath) as! CustomTableViewCell
        
        cell.leadingImage.image = UIImage(systemName: "person.fill")
        
        
        
        cell.textLabel?.text = "\(indexPath.row)"
        return cell

    }
    
    
}



// 문제점 1
// 이거 따로 뺴서 builder로 못만드나... 자꾸 길어지는데
// 그리고 enum에서 instance를 반환해도 괜찮은가..?(e.g UIImage 반환 vs name만 반환하고 뷰컨에서 UIImage 생성)
// 이게 enum이면 문제가 되는게 데이터를 저장할 방법이 마땅치 않음

// 문제점 2
// cell처럼 indexPath에 따라서 리턴해야하는 값은 뭔가 잘 안되네 흠..


// e.g) bmi calculator secureTextEnabled state, focusMode switch state etc...
//private enum FocusModeCellType: CaseIterable {
//    static let cellId: String = "FocusModeCell"
//    
//    case doNotDisturbMode
//    case sleep
//    case workHour
//    case privateTime
//    case shareAcrossDevice
//    
//    var imageName: String {
//        switch self {
//        case .doNotDisturbMode:
//            return "doNotDisturb"
//        case .sleep:
//            return "sleep"
//        case .workHour:
//            return "workHour"
//        case .privateTime:
//            return "privateTime"
//        case .shareAcrossDevice:
//            return "shareAcross"
//        }
//    }
//    
//    var imageTint: UIColor {
//        switch self {
//        case .doNotDisturbMode:
//            return .systemPurple
//        case .sleep, .shareAcrossDevice:
//            return .systemOrange
//        case .workHour:
//            return .systemGreen
//        case .privateTime:
//            return .systemBlue
//        }
//    }
//    
//    var title: String? {
//        switch self {
//        case .doNotDisturbMode:
//            return "방해 금지 모드"
//        case .sleep:
//            return "수면"
//        case .workHour:
//            return "업무"
//        case .privateTime:
//            return "개인 시간"
//        case .shareAcrossDevice:
//            return nil
//        }
//    }
//    
//    var detailTitle: String? {
//        switch self {
//        case .doNotDisturbMode:
//            return nil
//        case .sleep:
//            return nil
//        case .workHour: // 시간 변경할 수 있는 방법은?
//            return "09:00 ~. 6:00"
//        case .privateTime:
//            return nil
//        case .shareAcrossDevice:
//            return "모든 기기에서 공유"
//        }
//    }
//    
//    var trailingView: UIView? {
//        switch self {
//        case .doNotDisturbMode:
//            return UILabel()
//        case .sleep:
//            return nil
//        case .workHour:
//            return nil
//        case .privateTime:
//            return nil
//        case .shareAcrossDevice:
//            return UISwitch()
//        }
//    }
//    
//    var accesoryType: UITableViewCell.AccessoryType {
//        switch self {
//        case .doNotDisturbMode, .sleep, .workHour, .privateTime, .shareAcrossDevice:
//            return .detailDisclosureButton
//        }
//    }
//}
