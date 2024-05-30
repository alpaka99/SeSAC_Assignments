//
//  TravelCityDetailViewController.swift
//  TravelMagazineProject
//
//  Created by user on 5/29/24.
//

import UIKit

final class DetailCityViewController: UIViewController, Reusable {
    
    
    let detailHeaderImage: UIImageView = UIImageView()
    let detailHeaderLabel: UILabel = UILabel()
    
    let detailMainImage: UIImageView = UIImageView()
    
    let detailButtonStackView: UIStackView = UIStackView()
    let detailLikeButton: UIButton = UIButton()
    let detailCommentButton: UIButton = UIButton()
    let detailMessageButton: UIButton = UIButton()
    let detailBookMarkButton: UIButton = UIButton()
    
    let detailDescription: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationItems()
        
        layoutViews()
    }
    
    private func layoutViews() {
        layoutDetailHeader()
        layoutDetailMainImage()
        layoutButtons()
        layoutDetailDescription()
    }
    
    private func layoutDetailHeader() {
        layoutDetailHeaderImage()
        layoutDetailHeaderLabel()
    }
    
    private func layoutButtons() {
        layoutThreeButtons()
        layoutBookmarkButton()
    }
    
    private func layoutDetailHeaderImage() {
        self.view.addSubview(detailHeaderImage)
        
        detailHeaderImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            detailHeaderImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: ScreenSize.navigationBarConstant),
            detailHeaderImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            detailHeaderImage.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.1),
            detailHeaderImage.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.1),
            detailHeaderImage.heightAnchor.constraint(equalTo: detailHeaderImage.widthAnchor, multiplier: 1)
        ])
        
        detailHeaderImage.image = UIImage(systemName: "person.fill")
        detailHeaderImage.layer.cornerRadius = ScreenSize.width * 0.025
        detailHeaderImage.clipsToBounds = true
        detailHeaderImage.backgroundColor = .red
    }
    
    private func layoutDetailHeaderLabel() {
        self.view.addSubview(detailHeaderLabel)
        
        detailHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            detailHeaderLabel.topAnchor.constraint(equalTo: detailHeaderImage.topAnchor),
            detailHeaderLabel.leadingAnchor.constraint(equalTo: detailHeaderImage.trailingAnchor, constant: 8),
            detailHeaderLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8),
            detailHeaderLabel.bottomAnchor.constraint(equalTo: detailHeaderImage.bottomAnchor)
        ])
        
        detailHeaderLabel.text = "제목제목제목제목제목제목"
    }
    
    private func layoutDetailMainImage() {
        self.view.addSubview(detailMainImage)
        
        detailMainImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            detailMainImage.topAnchor.constraint(equalTo: detailHeaderLabel.bottomAnchor, constant: 8),
            detailMainImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            detailMainImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            detailMainImage.heightAnchor.constraint(equalTo: detailMainImage.widthAnchor, multiplier: 1)
        ])
        
        detailMainImage.backgroundColor = .systemGray4
        detailMainImage.image = UIImage(systemName: "camera.fill")
        detailMainImage.contentMode = .scaleAspectFit
    }
    
    private func layoutThreeButtons() {
        detailButtonStackView.axis = .horizontal
        
        detailButtonStackView.addArrangedSubview(detailLikeButton)
        detailButtonStackView.addArrangedSubview(detailCommentButton)
        detailButtonStackView.addArrangedSubview(detailMessageButton)
        
        self.view.addSubview(detailButtonStackView)
        
        detailButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            detailLikeButton.widthAnchor.constraint(equalToConstant: 44),
            detailLikeButton.heightAnchor.constraint(equalTo: detailLikeButton.widthAnchor, multiplier: 1),
            detailLikeButton.widthAnchor.constraint(equalToConstant: 44),
            detailCommentButton.heightAnchor.constraint(equalTo: detailCommentButton.widthAnchor, multiplier: 1),
            detailLikeButton.widthAnchor.constraint(equalToConstant: 44),
            detailMessageButton.heightAnchor.constraint(equalTo: detailMessageButton.widthAnchor, multiplier: 1),
            
            detailButtonStackView.topAnchor.constraint(equalTo: detailMainImage.bottomAnchor, constant: 8),
            detailButtonStackView.leadingAnchor.constraint(equalTo: detailHeaderImage.leadingAnchor),
        ])
        
        detailLikeButton.tintColor = .black
        detailCommentButton.tintColor = .black
        detailMessageButton.tintColor = .black
        
        detailLikeButton.setImage(UIImage(systemName: "heart", withConfiguration: SFSymbolConfig.large), for: .normal)
        
        detailCommentButton.setImage(UIImage(systemName: "message", withConfiguration: SFSymbolConfig.large), for: .normal)
        detailMessageButton.setImage(UIImage(systemName: "paperplane", withConfiguration: SFSymbolConfig.large), for: .normal)
        
        detailButtonStackView.spacing = 8
    }
    
    private func layoutBookmarkButton() {
        self.view.addSubview(detailBookMarkButton)
        
        detailBookMarkButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            detailBookMarkButton.centerYAnchor.constraint(equalTo: detailButtonStackView.centerYAnchor),
            detailBookMarkButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8),
            detailBookMarkButton.heightAnchor.constraint(equalTo: detailBookMarkButton.widthAnchor, multiplier: 1)
        ])
        
        detailBookMarkButton.tintColor = .black
        detailBookMarkButton.setImage(UIImage(systemName: "bookmark", withConfiguration: SFSymbolConfig.large), for: .normal)
    }
    
    private func layoutDetailDescription() {
        self.view.addSubview(detailDescription)
        
        detailDescription.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            detailDescription.topAnchor.constraint(equalTo: detailButtonStackView.bottomAnchor, constant: 8),
            detailDescription.leadingAnchor.constraint(equalTo: detailButtonStackView.leadingAnchor),
            detailDescription.trailingAnchor.constraint(equalTo: detailBookMarkButton.trailingAnchor),
            detailDescription.bottomAnchor.constraint(lessThanOrEqualTo: self.view.bottomAnchor)
        ])
        
        detailDescription.text = "설명들 설명들 설명들 설명들 설명들 설명들 설명들 설명들 설명들 설명들 설명들 설명들 설명들 설명들 설명들 설명들 설명들 설명들 설명들. "
        
        detailDescription.numberOfLines = 0
    }
    
    
    private func configureNavigationItems() {
        navigationItem.title = "관광지 화면"
        
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(dismissModal))
        leftBarButtonItem.tintColor = .black
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    private func configureData() {
        
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
