//
//  TestViewController.swift
//  day24 Assignment
//
//  Created by user on 6/23/24.
//

import UIKit

final class TestViewController: UIViewController {
    let testButton = UIButton()
        .image(systemName: "person")
        .tintColor(with: .orange)
        .backgroundColor(with: .systemBlue)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(testButton)
        
        testButton.snp.makeConstraints {
            $0.center.equalTo(view.snp.center)
        }
        
        testButton.addTarget(self, action: #selector(testButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func testButtonTapped(_ sender: UIButton) {
        print(#function)
    }
}
