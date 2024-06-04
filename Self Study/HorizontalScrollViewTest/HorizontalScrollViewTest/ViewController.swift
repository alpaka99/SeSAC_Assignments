//
//  ViewController.swift
//  HorizontalScrollViewTest
//
//  Created by user on 5/20/24.
//

// code base reference

// https://dev-dain.tistory.com/215
// https://sheikhamais.medium.com/how-to-use-the-new-uiscrollview-programmatically-baf270ee9b4

// storyboard implementation reference
// https://medium.com/@mufakkharulislamnayem/scrolling-in-a-horizontal-uistackview-with-storyboard-e02a9aab555b


import UIKit

class ViewController: UIViewController {
    var scrollContainer: UIStackView = UIStackView()
    var scrollView: UIScrollView = UIScrollView()
    var searchBar: UISearchBar = UISearchBar()
    var words: [String] = [
        "꾸안꾸", "좋못사", "복복복", "쌉파서블", "잼얘", "삼귀다",  "꾸안꾸", "좋못사", "복복복", "쌉파서블", "잼얘", "삼귀다",
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "신조어 검색기"
        
        self.view.addSubview(searchBar)
        self.view.addSubview(scrollView)
        
        layoutSearchbar()
        layoutScrollView()
        layoutHStackView()
        
    }
    
    func layoutSearchbar() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
    
    func layoutScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8),
            scrollView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        scrollView.bouncesHorizontally = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
    }
    
    func layoutHStackView() {
        scrollContainer.axis = .horizontal
        scrollContainer.spacing = 10
        
        fillStackView()
        
        scrollView.addSubview(scrollContainer)
        
        scrollContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollContainer.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            scrollContainer.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            
            scrollContainer.topAnchor.constraint(equalTo: scrollView.frameLayoutGuide.topAnchor),
            scrollContainer.bottomAnchor.constraint(equalTo: scrollView.frameLayoutGuide.bottomAnchor),
        ])
    }

    
    func fillStackView() {
        for i in 0..<words.count {
            let button = UIButton()
            button.setTitle(words[i], for: .normal)
            button.tag = i
            
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            
            button.setTitleColor(.black, for: .normal)
            button.layer.cornerRadius = 8
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.black.cgColor
            
            button.backgroundColor = .white
            
            scrollContainer.addArrangedSubview(button)
        }
    }
    
    @objc
    func buttonTapped(_ sender: UIButton) {
        if let clickedText = sender.titleLabel?.text {
            searchBar.text = clickedText
        }
    }
    
}
