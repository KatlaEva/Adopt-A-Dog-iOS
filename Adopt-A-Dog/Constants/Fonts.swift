//
//  Fonts.swift
//  Adopt-A-Dog
//
//  Created by Þórkatla Eva Víkingsdóttir on 05/05/2020.
//  Copyright © 2020 Þórkatla Eva Víkingsdóttir. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    struct Font {
        static func strawberry(size: CGFloat) -> UIFont {
            let font = UIFont(name: "Sweety Strawberry", size: size)!

            return UIFontMetrics.default.scaledFont(for: font)

        }
        static func caviarDreams(size: CGFloat) -> UIFont {
            let font = UIFont(name: "CaviarDreams", size: size)!

            return UIFontMetrics.default.scaledFont(for: font)
        }
        
        static func caviarDreamsBold(size: CGFloat) -> UIFont {
            let font = UIFont(name: "CaviarDreams-Bold", size: size)!

            return UIFontMetrics.default.scaledFont(for: font)
        }
        static func caviarDreamsBoldItalic(size: CGFloat) -> UIFont {
            let font = UIFont(name: "CaviarDreams-BoldItalic", size: size)!

            return UIFontMetrics.default.scaledFont(for: font)
        }
        static func caviarDreamsItalic(size: CGFloat) -> UIFont {
            let font = UIFont(name: "CaviarDreams-Italic", size: size)!

            return UIFontMetrics.default.scaledFont(for: font)
        }
    }
}
