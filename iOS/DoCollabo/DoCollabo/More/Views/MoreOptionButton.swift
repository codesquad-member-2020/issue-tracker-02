//
//  MoreOptionButton.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/23.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class MoreOptionButton: UIButton {
    
    private let height: CGFloat = 44.0
    private let leftInset: CGFloat = 20.0
    private let fontSize: CGFloat = 13.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        configureUI()
        configureLayout()
    }
    
    private func configureUI() {
        setTitleColor(.label, for: .normal)
        contentHorizontalAlignment = .leading
        titleEdgeInsets = UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: 0)
        titleLabel?.font = .systemFont(ofSize: fontSize, weight: .light)
    }
    
    private func configureLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}
