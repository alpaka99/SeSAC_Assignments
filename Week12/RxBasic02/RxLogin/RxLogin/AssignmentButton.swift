//
//  AssignmentButton.swift
//  RxLogin
//
//  Created by user on 8/4/24.
//

import UIKit

final class AssignmentButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setTitleColor(UIColor.white, for: .normal)
        backgroundColor = UIColor.black
        layer.cornerRadius = 10
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
