//
//  LeadingImageButton.swift
//  DoCollabo
//
//  Created by delma on 2020/06/08.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class LeadingImageButton: UIButton {
    
    private let cornerRadius: CGFloat = 10.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        configureImage()
        configureEdgeInsets()
        configureRoundCorner()
    }
    
    private func configureImage() {
        imageView?.contentMode = .scaleAspectFit
    }
    
    private func configureEdgeInsets() {
        imageEdgeInsets = UIEdgeInsets(top: 0, left: frame.width * 0.1, bottom: 0, right: 0)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: frame.width * 0.17, bottom: 0, right: 0)
    }
    
    private func configureRoundCorner() {
        roundCorner(cornerRadius: cornerRadius)
    }
}
