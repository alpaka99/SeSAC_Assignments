//
//  ShoppingTableViewController.swift
//  Day9Assignments
//
//  Created by user on 5/24/24.
//

import UIKit

final class ShoppingTableViewController:
    UITableViewController {
    
    private let shoppingTableViewIdentifier: String = "ShoppingTableViewCell"
    private let textField = UITextField()
    private var items: [CellState] = [
    ]
    

    
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
            let newItem = CellState.defaultCell(.unChecked, text, .unChecked)
            items.append(newItem)
            self.tableView.reloadData()
        }
    }
    
    // cell associated methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: shoppingTableViewIdentifier, for: indexPath) as? ShoppingTableViewCell {
                // 여기서 꺼내올때 out of bound error handling
            let item = items[indexPath.row]
            
            // leadingButton configuration
            var leadingConfig = UIButton.Configuration.plain()
            leadingConfig.image = UIImage(systemName: item.leadingButtonImageName)
            
            cell.leadingButton.configuration = leadingConfig
            cell.leadingButton.tintColor = .black
            cell.leadingButton.tag = indexPath.row
            cell.leadingButton.addTarget(self, action: #selector(leadingButtonTapped), for: .touchUpInside)
            
            // mid todoLabel configuration
            cell.todoLabel.text = item.title
            
            // trailing button configuration
            var trailingConfig = UIButton.Configuration.plain()
            trailingConfig.image = UIImage(systemName: item.trailingButtonImageName)
            
            cell.trailingButton.configuration = trailingConfig
            cell.trailingButton.tintColor = .black
            cell.trailingButton.tag = indexPath.row
            cell.trailingButton.addTarget(self, action: #selector(trailingButtonTapped), for: .touchUpInside)
            
            // cell configuration
            cell.selectionStyle = .none
            cell.backgroundColor = .systemGray5
            cell.layer.cornerRadius = 8
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: shoppingTableViewIdentifier, for: indexPath) as UITableViewCell
            cell.textLabel?.text = "Something went wrong...😞"
            return cell
        }
    }
    
    // MARK: 삭제전에 alert로 한번 물어보는 로직 구현
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    // MARK: 이 두개의 액션 tableViewController가 아니라 tableViewCell쪽으로 옮겨보기
    @objc
    func leadingButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        items[index] = items[index].toggleLeading()
        
        tableView.reloadRows(
            at: [IndexPath(row: index, section: 0)],
            with: .automatic
        )
    }
    
    // MARK: 즐겨찾기 해둔것들은 위로 옮기는 작업 해보기
    @objc
    func trailingButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        items[index] = items[index].toggleTrailingButton()
        tableView.reloadRows(
            at: [IndexPath(row: index, section: 0)],
            with: .automatic
        )
    }
    
    
}


enum CellState {
    case defaultCell(ButtonCheckState, String, ButtonCheckState)
    
    var title: String {
        switch self {
        case .defaultCell(_, let title, _):
            return title
        }
    }
    
    var leadingButtonState: ButtonCheckState {
        switch self {
        case .defaultCell(let leadingButtonState, _, _):
            return leadingButtonState
        }
    }
    
    var trailingButtonState: ButtonCheckState {
        switch self {
        case .defaultCell(_, _, let trailingButtonState):
            return trailingButtonState
        }
    }
    
    var leadingButtonImageName: String {
        switch self {
        case .defaultCell(let state, _, _):
            return state.isChecked ? "checkmark.square.fill" : "checkmark.square"
        }
    }
    
    var trailingButtonImageName: String {
        switch self {
        case .defaultCell(_, _, let state):
            return state.isChecked ? "star.fill" : "star"
        }
    }
    
    func toggleLeading() -> Self {
        switch self {
        case .defaultCell(let leadingState, let title, let trailingState):
            return .defaultCell(
                leadingState.toggledState,
                title,
                trailingState
            )
        }
    }
    
    func toggleTrailingButton() -> Self {
        switch self {
        case .defaultCell(let leadingState, let title, let trailingButtonState):
            return .defaultCell(
                leadingState,
                title,
                trailingButtonState.toggledState
            )
        }
    }
}


enum ButtonCheckState {
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
    
    var toggledState: Self {
        switch self {
        case .checked:
            return .unChecked
        case .unChecked:
            return .checked
        }
    }
}

// enum을 이용해서 여러가지 하는것들은 뷰를 그리는 3가지 과정(1. view heiararchy에 넣기, 2. layout잡기, 3. 실제 렌더링) 중에서 3번.실제 렌더링 관련해서만 하는게 좋을듯? -> layout은 미리 잡아두고, isHidden 혹은 opacity를 이용해서 보여주거나 안보여주거나 하게끔 해보자 -by Den님
// 왜냐하면 enum을 자주 바꾸는것에서 human error를 만들고 싶지 않아서 사용하는건데, 자주 바꾸는게 rendering phase에서 일어나니까.
// 나중에 확장 가능하면 좋겠다.
// 나중에 RenderingBuilder 정도로 protocol만들어서 template를 만들어도 좋겠다. 지금은 bolier plate가 너무 큼
