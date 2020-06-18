//
//  TitleHeaderBackgroundView.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/12.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class TitleHeaderBackgroundView: UIView {
    
    static let stretchedHeight: CGFloat = 240.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        roundCorner(cornerRadius: 16.0)
    }
}
