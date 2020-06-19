//
//  IssueHorizontalDescriptionLabel.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/16.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class IssueHorizontalDescriptionLabel: UILabel {

    private let titleFontSize: CGFloat = 15.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configureDescriptionLabel(with issue: Issue) {
        text = issue.description
    }
    
    private func configure() {
        configureUI()
    }

    private func configureUI() {
        text = "description"
        font = .systemFont(ofSize: titleFontSize, weight: .thin)
        numberOfLines = 2
    }
}
