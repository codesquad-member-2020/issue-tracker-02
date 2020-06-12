//
//  UIView+Animation.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/12.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

extension UIView {
    static func animateCurveEaseOut(
        withDuration: TimeInterval,
        animations: @escaping () -> Void,
        completion: ((Bool) -> Void)? = nil) {
        UIView.animate(
            withDuration: withDuration,
            delay: 0,
            usingSpringWithDamping: 1.1,
            initialSpringVelocity: 1,
            options: .curveEaseOut,
            animations: animations,
            completion: completion)
    }
}
