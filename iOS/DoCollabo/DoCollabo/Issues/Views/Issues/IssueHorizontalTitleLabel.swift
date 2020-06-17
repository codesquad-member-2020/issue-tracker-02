//
//  IssueHorizontalTitleLabel.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/11.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class IssueHorizontalTitleLabel: UILabel {
    
    private let titleFontSize: CGFloat = 17.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configureTitleLabel(with issue: Issue) {
        text = "#\(issue.id) \(issue.title)"
    }
    
    private func configure() {
        configureUI()
    }

    private func configureUI() {
        text = "Title"
        font = .systemFont(ofSize: titleFontSize, weight: .semibold)
        numberOfLines = 1
    }
}
