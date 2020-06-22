//
//  IssueMoreButton.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/20.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class IssueMoreButton: UIButton {
    
    static let size: CGSize = CGSize(width: 0.0, height: 24.0)
    
    private let image: UIImage? = UIImage(named: "issue.more")
    
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
    }
    
    private func configureUI() {
        setImage(image, for: .normal)
        tintColor = .darkGray
    }
}
