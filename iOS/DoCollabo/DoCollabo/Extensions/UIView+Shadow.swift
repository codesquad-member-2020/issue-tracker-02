//
//  UIView+Shadow.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/10.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

extension UIView {
    func drawShadow(color: UIColor, offset: CGSize, radius: CGFloat, opacity: CGFloat) {
        self.clipsToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = Float(opacity)
    }
}
