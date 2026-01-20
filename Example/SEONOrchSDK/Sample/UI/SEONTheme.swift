//
//  SEONTheme.swift
//  SEONOrchSDKSample
//
//  Created by Abbas Sabetinezhad on 16.01.26.
//

import UIKit

struct SEONTheme {
    struct Images {
        struct Common {
            static let checkboxChecked = UIImage(
                named: "CheckboxChecked",
                in: Bundle.main
            )?.tinted(with: SEONTheme.Colors.Text.accent)
            
            static let checkboxUnchecked = UIImage(
                named: "CheckboxUnchecked",
                in: Bundle.main
            )?.tinted(with: SEONTheme.Colors.Separator.onLight)
        }
    }
    
    struct Colors {
        static var accentColor = UIColor.traitedColor(light: UIColor(hex: "#0063FF"), dark: UIColor(hex: "#4185F2"))
        struct Text {
            static var accent: UIColor {
                return accentColor
            }
        }

        struct Separator {
            static var onLight: UIColor {
                UIColor.traitedColor(light: UIColor(hex: "#141517"), dark: UIColor(hex: "#FFFFFF"))
            }
        }
    }
}
