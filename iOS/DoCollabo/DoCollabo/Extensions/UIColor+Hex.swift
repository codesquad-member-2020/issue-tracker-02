//
//  UIColor+Hex.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/11.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

extension UIColor {
    func toHex() -> String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        let rgb: Int = (Int)(red * 255) << 16 | (Int)(green * 255) << 8 | (Int)(blue * 255) << 0
        return String(format: "#%06x", rgb)
    }
    
    func isDark() -> Bool {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return ((red + green + blue) * 255) < (255 * 3) / 2
    }
}
