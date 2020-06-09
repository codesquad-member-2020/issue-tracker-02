//
//  NibView.swift
//  DoCollabo
//
//  Created by delma on 2020/06/09.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

class NibView: UIView, NibReplaceable {
    open override func awakeAfter(using coder: NSCoder) -> Any? {
        guard subviews.isEmpty,
            let nibView = replacedByNibView()
            else { return self }
        return nibView
    }
}
public protocol NibReplaceable where Self: UIView {}
public extension NibReplaceable {
    public func replacedByNibView() -> Self? {
        let nibView = type(of: self).nibView()
//        nibView?.copyProperties(from: self)
//        nibView?.copyConstraints(from: self)
        return nibView
    }
    static func nibView() -> Self? {
        guard let nibViews = Bundle(for: self).loadNibNamed(nibName, owner: nil, options: nil),
            let nibView = nibViews.first(where: { type(of: $0) == self } ) as? Self
            else {
                fatalError("\(#function) Could not find an instance of class \(self) in \(nibName) xib")
        }
        return nibView
    }
    static var nibName: String {
        return String(describing: self)
    }
}
