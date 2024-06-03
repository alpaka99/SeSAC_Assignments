//
//  ImageBuildable.swift
//  TravelMagazineProject
//
//  Created by user on 5/29/24.
//

import Foundation
import UIKit

protocol ImageViewBuildable {
    var imageViews: [ImageViewType : UIImageView] { get set }
    func buildImageViewsUI()
}

extension ImageViewBuildable {
    func buildImageViewsUI() {
        self.imageViews.keys.forEach { imageViewType in
            buildImageViewUI(imageViewType)
        }
    }
    
    func buildImageViewUI(_ imageViewType: ImageViewType) {
        if let imageView = imageViews[imageViewType] {
            imageView.backgroundColor = imageViewType.backgroundColor
            imageView.layer.borderColor = imageViewType.borderColor
            imageView.layer.borderWidth = imageViewType.borderWidth
            imageView.clipsToBounds = imageViewType.clipsToBounds
            imageView.layer.cornerRadius = imageViewType.cornerRadius
            imageView.contentMode = imageViewType.contentMode
        }
    }
}
