//
//  TalkRoomViewController.swift
//  ReTravelMagazine
//
//  Created by user on 6/3/24.
//

import UIKit

final class TalkRoomViewController: UIViewController {
    
    private let tableView: UITableView = UITableView()
    private let textFieldBackground: UIView = UIView()
    private let textField: UITextField = UITextField()
    private let submitButton: UIButton = UIButton()
    private var chats: [Chat] = []
    
    override func loadView() {
        super.loadView()
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutComponents()
        configureComponents()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
        tableView.scrollToRow(at: IndexPath(row: chats.count-1, section: 0), at: .bottom, animated: true)
    }
    
    private func layoutComponents() {
        layoutTableView()
        layoutTextFieldBackground()
        layoutTextField()
        layoutSubmitButton()
    }
    
    private func layoutTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func layoutTextFieldBackground() {
        view.addSubview(textFieldBackground)
        
        textFieldBackground.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textFieldBackground.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 8),
            textFieldBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textFieldBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textFieldBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(tabBarController?.tabBar.frame.height ?? 0) - 8),
            textFieldBackground.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        textFieldBackground.backgroundColor = .systemGray6
        textFieldBackground.layer.cornerRadius = 8
    }
    
    private func layoutTextField() {
        textFieldBackground.addSubview(textField)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: textFieldBackground.topAnchor, constant: 8),
            textField.leadingAnchor.constraint(equalTo: textFieldBackground.leadingAnchor, constant: 8),
            textField.bottomAnchor.constraint(equalTo: textFieldBackground.bottomAnchor, constant: -8),
        ])
        
        textField.placeholder = "메세지를 입력하세요"
    }
    
    private func layoutSubmitButton() {
        textFieldBackground.addSubview(submitButton)
        
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: textFieldBackground.topAnchor, constant: 8),
            submitButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 8),
            submitButton.trailingAnchor.constraint(equalTo: textFieldBackground.trailingAnchor, constant: -8),
            submitButton.bottomAnchor.constraint(equalTo: textFieldBackground.bottomAnchor, constant: -8),
            submitButton.widthAnchor.constraint(equalTo: submitButton.heightAnchor, multiplier: 1)
        ])
        
        submitButton.setImage(UIImage(systemName: "arrowtriangle.forward"), for: .normal)
        submitButton.tintColor = .systemGray4
    }
    
    private func configureComponents() {
        configureTableView()
        configureKeyboard()
    }
    
    private func configureTableView() {
        tableView.delegate  = self
        tableView.dataSource = self
        
        tableView.separatorColor = .clear
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
        tableView.register(OpponentTalkCell.self, forCellReuseIdentifier: OpponentTalkCell.reuseIdentifier)
        tableView.register(UserTalkCell.self, forCellReuseIdentifier: UserTalkCell.reuseIdentifier)
    }
    
    private func configureKeyboard() {
        textField.addTarget(self, action: #selector(submitted), for: .editingDidEndOnExit)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc
    func submitted(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @objc
    func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            UIView.animate(withDuration: 0.1) { [weak self] in
                // force unwrapping 수정
                NSLayoutConstraint.activate([
                    self!.textFieldBackground.bottomAnchor.constraint(equalTo: self!.view.bottomAnchor, constant: -(keyboardFrame.cgRectValue.height+8))
                ])
            }
        }
    }
    
    @objc
    func keyboardDidHide(_ notification: Notification) {
        print(#function)
        
//        textFieldBackground.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -8).isActive = true
        layoutTextFieldBackground()
    }
    
    internal func configureData(_ data: [Chat]) {
        chats = data
    }
}

extension TalkRoomViewController: UITableViewDelegate, UITableViewDataSource {
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = chats[indexPath.row]
        
        // MARK: 이 과정을 간소화 하는 방법이 있을까?? tableView.dequeReuseableCell을 해야해서 다른 객체에서 cell을 만들어서 전달하기가 까다로움.
        if data.user == .user {
            if let cell = tableView.dequeueReusableCell(withIdentifier: UserTalkCell.reuseIdentifier, for: indexPath) as? UserTalkCell {
                
                cell.configureData(data)
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath) as UITableViewCell
                
                cell.textLabel?.text = TableViewCellConstants.basicCellText
                
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: OpponentTalkCell.reuseIdentifier, for: indexPath) as? OpponentTalkCell {
                
                cell.configureData(data)
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath) as UITableViewCell
                
                cell.textLabel?.text = TableViewCellConstants.basicCellText
                
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
