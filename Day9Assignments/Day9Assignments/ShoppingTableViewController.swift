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
    private var items: [CellState] = []
    private var favoritesEndItemPointer: Int = -1

    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.tableView.rowHeight = 44
        self.tableView.keyboardDismissMode = .onDrag
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textField.becomeFirstResponder()
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
        addItemToTodoList()
    }
    
    private func addItemToTodoList() {
        if let text = textField.text {
            // do something to add new item
            items.append(CellState.initialize(text))
            self.tableView.reloadData()
            super.becomeFirstResponder()
            self.textField.becomeFirstResponder()
        }
    }
    
    // section associated methods
    
    
    
    // cell associated methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: shoppingTableViewIdentifier, for: indexPath) as? ShoppingTableViewCell {
            
            let index = indexPath.row
            
            // 여기서 꺼내올때 out of bound error handling
            let item = items[indexPath.row]
            
            // cell configuration
            cellConfiguration(cell: cell, item: item)
            
            // leadingButton configuration
            leadingButtonConfiguration(cell: cell, item: item, tag: index)
            
            // mid todoLabel configuration
            midTodoLabelConfiguration(cell: cell, text: item.title)
            
            // trailing button configuration
            trailingButtonConfiguration(cell: cell, item: item, tag: index)
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: shoppingTableViewIdentifier, for: indexPath) as UITableViewCell
            cell.textLabel?.text = "Something went wrong...😞"
            return cell
        }
    }
    
    private func cellConfiguration(cell: ShoppingTableViewCell, item: CellState) {
        cell.selectionStyle = .none
        switch item.trailingButtonState {
        case .checked:
            cell.backgroundColor = .systemTeal
        case .unChecked:
            cell.backgroundColor = .systemGray5
        }
        
        cell.layer.cornerRadius = 8
    }
    
    private func leadingButtonConfiguration(cell: ShoppingTableViewCell, item: CellState, tag: Int) {
        var leadingConfig = UIButton.Configuration.plain()
        leadingConfig.image = UIImage(systemName: item.leadingButtonImageName)
        cell.leadingButton.configuration = leadingConfig
        
        cell.leadingButton.tintColor = .black
        cell.leadingButton.tag = tag
        cell.leadingButton.addTarget(self, action: #selector(leadingButtonTapped), for: .touchUpInside)
    }
    
    private func midTodoLabelConfiguration(cell: ShoppingTableViewCell, text: String) {
        cell.todoLabel.text = text
    }
    
    private func trailingButtonConfiguration(cell: ShoppingTableViewCell, item: CellState, tag: Int) {
        var trailingConfig = UIButton.Configuration.plain()
        trailingConfig.image = UIImage(systemName: item.trailingButtonImageName)
        cell.trailingButton.configuration = trailingConfig
        
        cell.trailingButton.tintColor = .black
        cell.trailingButton.tag = tag
        cell.trailingButton.addTarget(self, action: #selector(trailingButtonTapped), for: .touchUpInside)
    }
    
    // MARK: 삭제전에 alert로 한번 물어보는 로직 구현
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    // MARK: 이 두개의 액션 tableViewController가 아니라 tableViewCell쪽으로 옮겨보기
    @objc
    func leadingButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        items[index] = items[index].toggleLeadingButton()
        
        tableView.reloadRows(
            at: [IndexPath(row: index, section: 0)],
            with: .automatic
        )
    }
    
    // MARK: 즐겨찾기 해둔것들은 위로 옮기는 작업 해보기 -> 문제점: 현재 tag는 Int로만 받아서 하나의 섹션에서는 구분가능한데 두개의 섹션에서는 어떤 섹션에서 눌렀는지 구분 불가 e.g) 0번째 섹션의 0번째와, 1번째 섹션의 0번째는 같은 tag가 같이 0
    // 음... 이걸 하려면 contextMenu를 띄워서 해야겠는데...?
    
    // 카톡 단톡방 방법
    // 1. 즐겨찾기 설정한것들(.unChecked -> .checked인 것들)은 items의 가장 앞에 넣기
    // 2. 즐겨찾기 해제된 것들(.checked -> .unChecked인 것들)은 updatedAt의 순서대로 sort
    
    
    // 이걸 구현할 내 생각
    // 1. favorite array, normal array 2개 운용
    // 2. favorite array에 갈때(즐찾 설정)는 그냥 array.append()
    // 3. normal array에 갈때(즐찾 해제)는 array.append()하고 sort()
    @objc
    func trailingButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        
        let currentPosition: SectionType = (index <= favoritesEndItemPointer) ? .favorites : .common
        switch currentPosition {
        case .favorites:
            moveItemToCommons(from: index)
        case .common:
            moveItemToFavorites(from: index)
        }
    }
    
    private func moveItemToFavorites(from index: Int) {
        favoritesEndItemPointer += 1
        let item = items.remove(at: index).toggleTrailingButton()
        items.insert(item, at: favoritesEndItemPointer)
        
        self.tableView.reloadData()
    }
    
    private func moveItemToCommons(from index: Int) {
        favoritesEndItemPointer -= 1
        let item = items.remove(at: index).toggleTrailingButton()
        putItemInCommonArray(item, start: favoritesEndItemPointer+1)
        
        tableView.reloadData()
    }
    
    // MARK: 위치를 생성된 순서대로 계산해서 넣기
    private func putItemInCommonArray(_ item: CellState, start: Int) {
        for index in start..<items.count {
            if item.createdAt < items[index].createdAt {
                items.insert(item, at: index)
                return
            }
        }
        items.append(item)
    }
}

private enum SectionType {
    case favorites
    case common
}


private enum CellState {
    case defaultCell(ButtonCheckState, String, ButtonCheckState, Date)
    
    var title: String {
        switch self {
        case .defaultCell(_, let title, _, _):
            return title
        }
    }
    
    var leadingButtonState: ButtonCheckState {
        switch self {
        case .defaultCell(let leadingButtonState, _, _, _):
            return leadingButtonState
        }
    }
    
    var trailingButtonState: ButtonCheckState {
        switch self {
        case .defaultCell(_, _, let trailingButtonState, _):
            return trailingButtonState
        }
    }
    
    var createdAt: Date {
        switch self {
        case .defaultCell(_, _, _, let date):
            return date
        }
    }
    
    var leadingButtonImageName: String {
        switch self {
        case .defaultCell(let state, _, _, _):
            return state.isChecked ? "checkmark.square.fill" : "checkmark.square"
        }
    }
    
    var trailingButtonImageName: String {
        switch self {
        case .defaultCell(_, _, let state, _):
            return state.isChecked ? "star.fill" : "star"
        }
    }
    
    static func initialize(_ title: String) -> Self {
        switch self {
        default:
            return .defaultCell(.unChecked, title, .unChecked, Date.now)
        }
    }
    
    func toggleLeadingButton() -> Self {
        switch self {
        case .defaultCell(let leadingState, let title, let trailingState, let updatedAt):
            return .defaultCell(
                leadingState.toggledState,
                title,
                trailingState,
                updatedAt
            )
        }
    }
    
    func toggleTrailingButton() -> Self {
        switch self {
        case .defaultCell(let leadingState, let title, let trailingButtonState, let updatedAt):
            return .defaultCell(
                leadingState,
                title,
                trailingButtonState.toggledState,
                updatedAt
            )
        }
    }
}

private enum ButtonCheckState {
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
