//
//  PopularCityTableViewCell.swift
//  TravelMagazineProject
//
//  Created by user on 5/27/24.
//

import Kingfisher
import UIKit

final class PopularCityTableViewCell: PopularCityBuildableCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var gradeLabel: UILabel!
    
    lazy var labels: [LabelType : UILabel] = [
        .popularCityTitle : titleLabel,
        .popularCityDescription : descriptionLabel,
        .popularCityGrade : gradeLabel
    ]
    
    @IBOutlet var cityImageView: UIImageView!
    lazy var imageViews: [ImageViewType : UIImageView] = [ .popularCity : cityImageView ]
    
    @IBOutlet var likeButton: UIButton!
    lazy var buttons: [ButtonType : UIButton] = [ .likeButton(.normal) : likeButton ]
    
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
        buildLabelsUI()
        buildImageViewsUI()
        buildButtonsUI()
    }
    
    private func addComponentActions() {
        addLikeButtonAction()
    }
    
    internal func configureData(_ data: Travel) {
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        gradeLabel.text = data.gradeLabel
        isLike = data.isLike
         // MARK: 이 부분을 지금 두번씩 불러오고 있는데 한번만 불러올 방법이 없을까?
        isLike ? buildButtonUI(.likeButton(.pressed)) : buildButtonUI(.likeButton(.normal))
        
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
        //MARK: 여기에서 key도 toggle 해줘야함
        isLike.toggle()
        switch isLike {
        case true:
            buildButtonUI(.likeButton(.pressed))
//            buttons.switchKey(for: .favoriteButton(.normal), with: .favoriteButton(.pressed))
        case false:
            buildButtonUI(.likeButton(.normal))
        }
        
    }
}

extension Dictionary {
    mutating func switchKey(for originalKey: Self.Key, with newKey: Self.Key) {
        self[newKey] = self.removeValue(forKey: originalKey)
    }
}




