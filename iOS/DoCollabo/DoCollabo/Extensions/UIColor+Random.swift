//
//  UIColor+Random.swift
//  DoCollabo
//
//  Created by delma on 2020/06/21.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

extension UIColor {
    static func generateRandomColor(alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(
            red: .random(in: 0...1.0),
            green: .random(in: 0...1.0),
            blue: .random(in: 0...1.0),
            alpha: alpha)
    }
}
