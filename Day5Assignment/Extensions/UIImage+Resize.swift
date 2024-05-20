//
//  UIImage+Resize.swift
//  Day5Assignment
//
//  Created by user on 5/20/24.
//

import UIKit

extension UIImage {
    func resizeImage(withSize size: CGSize) -> UIImage {
        let image = UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(
                origin: .zero,
                size: size
            ))
        }
        
        return image.withRenderingMode(self.renderingMode)
    }
}
