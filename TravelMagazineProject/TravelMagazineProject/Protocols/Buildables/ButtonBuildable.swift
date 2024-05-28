//
//  ButtonBuildable.swift
//  TravelMagazineProject
//
//  Created by user on 5/29/24.
//

import Foundation
import UIKit

protocol ButtonBuildable {
    var buttons: [ButtonType : UIButton] { get set }
    func buildButtonsUI()
}

extension ButtonBuildable {
    func buildButtonsUI() {
        buttons.keys.forEach { buttonType in
            buildButtonUI(buttonType)
        }
    }
    
    func buildButtonUI(_ buttonType: ButtonType) {
        if let button = buttons[buttonType] {
            button.setImage(UIImage(systemName: buttonType.systemName), for: .normal)
            button.tintColor = buttonType.tintColor
        }
    }
    
    mutating func toggleButtonImage(_ buttonType: ButtonType) {
        if let button = buttons[buttonType] {
            buttons.switchKey(for: buttonType, with: buttonType.toggle())
            buildButtonUI(buttonType.toggle())
        }
    }
}
