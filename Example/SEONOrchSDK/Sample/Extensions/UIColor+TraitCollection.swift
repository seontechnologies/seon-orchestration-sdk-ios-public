//
//  UIColor+TraitCollection.swift
//  Pods
//
//  Created by Abbas Sabetinezhad on 13.11.24.
//

import UIKit

extension UIColor {
    static func traitedColor(light: UIColor, dark: UIColor? = nil) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { traitCollection -> UIColor in
                switch traitCollection.userInterfaceStyle {
                case .dark:
                    return dark ?? light
                default:
                    return light
                }
            }
        } else {
            return light
        }
    }
}
