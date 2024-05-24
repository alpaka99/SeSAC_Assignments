//
//  ShoppingTableViewController.swift
//  Day9Assignments
//
//  Created by user on 5/24/24.
//

import UIKit

final class ShoppingTableViewController:
    UITableViewController {
    
    let shoppingTableViewIdentifier: String = "ShoppingTableViewCell"
    let textField = UITextField()

    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.tableView.rowHeight = 44
        self.tableView.keyboardDismissMode = .onDrag
        
    }
    
    // section associated methods
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let textFieldBaseView = UIView()
        textFieldBaseView.backgroundColor = .systemGray6
        textFieldBaseView.layer.cornerRadius = 8
        
        let textField = UITextField()
        textField.placeholder = "무엇을 구매하실건가요?"
        textField.borderStyle = .none
        textField.backgroundColor = .systemGray6
        textField.clearButtonMode = .whileEditing
        
        textFieldBaseView.addSubview(textField)
        textField.addTarget(self, action: #selector(textFieldSubmitted), for: .editingDidEndOnExit)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        let submitButton = UIButton()
        submitButton.addTarget(self, action: #selector(textFieldSubmitted), for: .touchUpInside)
        textFieldBaseView.addSubview(submitButton)
        
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
        var config = UIButton.Configuration.plain()
        
        config.title = "추가"
        config.background.backgroundColor = .systemGray5
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: textFieldBaseView.leadingAnchor, constant: 8),
            textField.centerYAnchor.constraint(equalTo: textFieldBaseView.centerYAnchor),
            textField.heightAnchor.constraint(equalToConstant: 44),
            textField.trailingAnchor.constraint(equalTo: submitButton.leadingAnchor, constant: -8),
            textField.topAnchor.constraint(equalTo: textFieldBaseView.topAnchor, constant: 8),
            textField.bottomAnchor.constraint(equalTo: textFieldBaseView.bottomAnchor, constant: -8),
        ])
        
        
        
        submitButton.configuration = config
        
        submitButton.layer.cornerRadius = 8
        submitButton.tintColor = .black
        
        
        NSLayoutConstraint.activate([
            submitButton.trailingAnchor.constraint(equalTo: textFieldBaseView.trailingAnchor, constant: -10),
            submitButton.centerYAnchor.constraint(equalTo: textFieldBaseView.centerYAnchor, constant: 0)
        ])
        
        return textFieldBaseView
    }
    
    @objc
    private func textFieldSubmitted() {
        print(#function)
        addItemToTodoList()
    }
    
    private func addItemToTodoList() {
        if let text = textField.text {
            // do something to add new item
            var newItem = CellState.defaultCell(.unChecked, text, .unChecked)
            
        }
    }
    
    // cell associated methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: shoppingTableViewIdentifier, for: indexPath) as UITableViewCell
        
        return cell
    }
    
    
    @objc
    func leadingButtonTapped(_ sender: UIButton) {
        
    }
    
    @objc
    func trailingButtonTapped(_ sender: UIButton) {
        
    }
}


enum CellState {
    case defaultCell(LeadingButtonState, String, TrailingButtonState)
    
    var title: String {
        switch self {
        case .defaultCell(_, let title, _):
            return title
        }
    }
    
    var leadingButtonState: LeadingButtonState {
        switch self {
        case .defaultCell(let leadingButtonState, _, _):
            return leadingButtonState
        }
    }
    
    var trailingButtonState: TrailingButtonState {
        switch self {
        case .defaultCell(_, _, let trailingButtonState):
            return trailingButtonState
        }
    }
}


enum LeadingButtonState {
    case checked
    case unChecked
    
    var isChecked: Bool {
        switch self {
        case .checked:
            return true
        case .unChecked:
            return false
        }
    }
}

enum TrailingButtonState {
    case checked
    case unChecked
    
    var isChecked: Bool {
        switch self {
        case .checked:
            return true
        case .unChecked:
            return false
        }
    }
}
