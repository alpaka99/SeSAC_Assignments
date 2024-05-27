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
        setTitleLabelUI()
        setDescriptionLabelUI()
        setGradeLabelUI()
        setCityImageViewUI()
        setLikeButtonUI()
    }
    
    private func addComponentActions() {
        addLikeButtonAction()
    }
    
    private func setTitleLabelUI() {
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        titleLabel.textColor = .black
    }
    
    private func setDescriptionLabelUI() {
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        descriptionLabel.textColor = .systemGray3
    }
    
    private func setGradeLabelUI() {
        gradeLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        gradeLabel.textColor = .systemGray4
    }
    
    private func setCityImageViewUI() {
        cityImageView.layer.cornerRadius = 8
        cityImageView.clipsToBounds = true
        cityImageView.backgroundColor = .systemGray4
        cityImageView.contentMode = .scaleAspectFill
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
        gradeLabel.text = "\(data.grade.getStars()) (\(data.grade ?? 0)) • 저장 \(data.save?.formatted() ?? "0")"
        isLike = data.like ?? false
        setLikeButtonUI() // MARK: 이 부분을 지금 두번씩 불러오고 있는데 한번만 불러올 방법이 없을까?
        
        cityImageView.kf.indicatorType = .activity
        if let photoUrl = data.travel_image, let url = URL(string: photoUrl) {
            DataManager.shared.fetchImage(url) {[weak self] image in
                self?.cityImageView.image = image
                //            cityImageView.kf.setImage(with: url)
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
