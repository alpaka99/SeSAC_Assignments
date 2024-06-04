//
//  ViewController.swift
//  GeneralAlert
//
//  Created by user on 6/4/24.
//

import UIKit

class ViewController: UIViewController {
    
//    var data: [Int] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    var data: [String] = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k"]
    let tableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.title = "General Alert"
        configureTableView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(notificationAlertShown), name: NSNotification.Name("showNotificationAlert"), object: nil)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        showProtocolAlert(indexPath.row, completion: deleteData)
    }
    
    @objc
    func notificationAlertShown(_ notification: UNNotification) {
        print(#function)
    }
}


protocol GeneralAlert {
    associatedtype DataType
    
    var data: [DataType] { get set }
    
    func showProtocolAlert(_ index: Int, completion: @escaping (Int) -> ())
    
    func showNotificationAlert(_ index: Int)
}


extension ViewController: GeneralAlert {
    func showProtocolAlert(_ index: Int, completion: @escaping (Int) -> ()) {
        let alertController = UIAlertController(
            title: "GeneralAlert",
            message: "This is general alert for \(data[index])",
            preferredStyle: .alert
        )
        
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { _ in
            completion(index) // 이 삭제 버튼이 눌렸을때 completion 함수를 호출 -> 매개변수로 받은 completion 함수를 ViewController가 아닌 다른 곳(AlertButton)에서 실행하는것이기 때문에 @escaping
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
    // ViewController의 특정 데이터를 삭제하는것
    func deleteData(_ index: Int) {
        data.remove(at: index)
        tableView.reloadData()
    }
    
    
    func showNotificationAlert(_ index: Int) {
        NotificationCenter.default.post(name: NSNotification.Name("showNotificationAlert"), object: index)
    }
}
