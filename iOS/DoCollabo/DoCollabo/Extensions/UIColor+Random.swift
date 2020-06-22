//
//  UIColor+Random.swift
//  DoCollabo
//
//  Created by delma on 2020/06/21.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

extension UIColor {
    func random() -> UIColor {
        return UIColor(
            red: .random(in: 0...1.0),
            green: .random(in: 0...1.0),
            blue: .random(in: 0...1.0),
            alpha: 1.0)
    }
}
