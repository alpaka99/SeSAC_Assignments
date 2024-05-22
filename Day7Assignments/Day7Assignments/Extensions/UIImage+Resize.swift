//
//  UIImage+Resize.swift
//  Day7Assignments
//
//  Created by user on 5/22/24.
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
