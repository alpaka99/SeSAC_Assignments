//
//  TravelCityDetailViewController.swift
//  TravelMagazineProject
//
//  Created by user on 5/29/24.
//

import UIKit

final class DetailCityViewController: UIViewController, Reusable {
    
    let detailCityLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationItems()
        
        layoutViews()
    }
    
    private func layoutViews() {
        layoutDetailTitle()
    }
    
    private func layoutDetailTitle() {
        self.view.addSubview(detailCityLabel)
        
        detailCityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            detailCityLabel.topAnchor.constraint(equalTo: self.view.topAnchor),
            detailCityLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            detailCityLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            detailCityLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
        
        detailCityLabel.text = "관광지 화면"
        detailCityLabel.textAlignment = .center
    }
    
    private func configureNavigationItems() {
        navigationItem.title = "관광지 화면"
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(dismissModal))
        leftBarButtonItem.tintColor = .black
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
}

final class TestCityViewController: UIViewController, Reusable {
    var switchView: UIView = DetailCityView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationItems()
    }
    
    func switchView(_ isAd: Bool) {
        if isAd {
            switchView = DetailCityAdView()
        } else {
            switchView = DetailCityView()
        }
        
        layoutView()
    }
    
    func layoutView() {
        switchView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureNavigationItems() {
        navigationItem.title = "관광지 화면"
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(dismissModal))
        leftBarButtonItem.tintColor = .black
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
}



extension UIViewController {
    @objc
    func pop() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func dismissModal() {
        dismiss(animated: true)
    }
}



class DetailCityView: UIView {
    let title: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutViews()
        
        title.text = "관광지"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutViews() {
        title.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            title.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}


class DetailCityAdView: UIView {
    let title: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutViews()
        
        title.text = "광고"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutViews() {
        title.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            title.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}



//@objc
//protocol Testable: AnyObject {
//    @objc
//    optional func testFunc()
//    
//    func notOptional()
//}

//
//class TestClass: Testable {
//    func notOptional() {
//        <#code#>
//    }
//}
//extension Testable {
//    func notOptional() {
//        
//    }
//}
