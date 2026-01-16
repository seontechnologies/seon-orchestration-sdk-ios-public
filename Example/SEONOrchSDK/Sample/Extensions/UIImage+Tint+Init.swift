//
//  UIImage+Tint+Init.swift
//  Pods
//
//  Created by Abbas Sabetinezhad on 13.11.24.
//

import UIKit

extension UIImage {
    convenience init?(named name: String, in bundle: Bundle) {
        if #available(iOS 13.0, *) {
            self.init(named: name, in: bundle, with: nil)
        } else {
            self.init(named: name, in: bundle, compatibleWith: nil)
        }
    }

    func tinted(with color: UIColor) -> UIImage? {
        if #available(iOS 13.0, *) {
            return self.withTintColor(color)
        } else {
            UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
            defer { UIGraphicsEndImageContext() }

            guard let context = UIGraphicsGetCurrentContext(), let cgImage = self.cgImage else { return nil }

            // Draw the original image
            let rect = CGRect(origin: .zero, size: self.size)
            context.translateBy(x: 0, y: self.size.height)
            context.scaleBy(x: 1.0, y: -1.0)
            context.clip(to: rect, mask: cgImage)

            // Fill the area with the color
            color.setFill()
            context.fill(rect)

            // Get the tinted image
            return UIGraphicsGetImageFromCurrentImageContext()
        }
    }
}
