//
//  UIViewController+Extension.swift
//  Day7Assignments
//
//  Created by user on 5/27/24.
//

import UIKit

extension UIViewController {
    func setBackground() {
        self.view.backgroundColor = .systemOrange
    }
    
    func showAlert(title: String) {
        let ac = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        let openButton = UIAlertAction(title: "열기", style: .default)
        let cancelButton = UIAlertAction(title: "취소", style: .cancel)
        
        ac.addAction(openButton)
        ac.addAction(cancelButton)
        
        present(ac, animated: true)
    }
}
