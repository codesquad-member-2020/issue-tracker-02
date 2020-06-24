//
//  PaddingLabel.swift
//  DoCollabo
//
//  Created by delma on 2020/06/24.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

class PaddingLabel: UILabel {

    var padding: UIEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)

    override func drawText(in rect: CGRect) {
        let paddingRect = rect.inset(by: padding)
        super.drawText(in: paddingRect)
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        return contentSize
    }
}
