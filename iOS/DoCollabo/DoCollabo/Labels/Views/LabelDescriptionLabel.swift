//
//  LabelDescriptionLabel.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/24.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class LabelDescriptionLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override func draw(_ rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0)
        super.drawText(in: rect.inset(by: insets))
    }
    
    private func configure() {
        configureUI()
    }

    private func configureUI() {
        numberOfLines = 1
        font = .systemFont(ofSize: 14, weight: .regular)
        textColor = .label
    }
}
