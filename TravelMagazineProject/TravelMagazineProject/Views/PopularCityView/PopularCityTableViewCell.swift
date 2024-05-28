//
//  PopularCityTableViewCell.swift
//  TravelMagazineProject
//
//  Created by user on 5/27/24.
//

import Kingfisher
import UIKit

class PopularCityTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var gradeLabel: UILabel!
    
    lazy var labels: [LabelType : UILabel] = [
        .popularCityTitle : titleLabel,
        .popularCityDescription : descriptionLabel,
        .popularCityGrade : gradeLabel
    ]
    
    @IBOutlet var cityImageView: UIImageView!
    
    @IBOutlet var likeButton: UIButton!
    
    private var isLike: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // layoutComponents -> done in storyboard
        
        // setComponent UI
        setComponentsUI()
        
        // configure data -> from viewcontroller
        
        // add Component Actions
        addComponentActions()
    }
    
    private func setComponentsUI() {
        setLabelsUI()
        setCityImageViewUI(.popularCity)
        setLikeButtonUI()
    }
    
    private func addComponentActions() {
        addLikeButtonAction()
    }
    
    
    private func setLabelsUI() {
        labels.keys.forEach { type in
            if let label = labels[type] {
                label.numberOfLines = type.numberOfLines
                label.textAlignment = type.textAlignment
                label.font = UIFont.systemFont(ofSize: type.fontSize, weight: type.fontWeight)
                label.textColor = type.textColor
            }
        }
    }
    
    private func setCityImageViewUI(_ type: ImageViewType) {
        cityImageView.layer.cornerRadius = type.cornerRadius
        cityImageView.clipsToBounds = type.clipsToBounds
        cityImageView.backgroundColor = type.backgroundColor
        cityImageView.contentMode = type.contentMode
    }
    
    private func setLikeButtonUI() {
        if isLike {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeButton.tintColor = .red
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likeButton.tintColor = .white
        }
    }
    
    
    internal func configureData(_ data: Travel) {
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        gradeLabel.text = data.gradeLabel
        isLike = data.isLike
        setLikeButtonUI() // MARK: 이 부분을 지금 두번씩 불러오고 있는데 한번만 불러올 방법이 없을까?
        
        cityImageView.kf.indicatorType = .activity
        if let photoUrl = data.travel_image, let url = URL(string: photoUrl) {
            DataManager.shared.fetchImage(url) {[weak self] image in
                self?.cityImageView.image = image
            }
        }
    }
    
    private func addLikeButtonAction() {
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func likeButtonTapped() {
        isLike.toggle()
        setLikeButtonUI()
    }
}




protocol ButtonBuildable {
    var buttons: [UIButton] { get set }
    
    func buildButton(_ type: ButtonType)
}


enum ButtonType {
    
}
