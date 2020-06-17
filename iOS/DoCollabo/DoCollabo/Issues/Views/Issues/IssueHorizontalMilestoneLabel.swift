//
//  IssueHorizontalMilestoneLabel.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/16.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class IssueHorizontalMilestoneLabel: UILabel {

    private let titleFontSize: CGFloat = 13.0
    private let padding: UIEdgeInsets = UIEdgeInsets(top: 4, left: 12, bottom: 4, right: 12)
    private let color: UIColor = .lightGray

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(
            width: size.width + padding.left + padding.right,
            height: size.height + padding.top + padding.bottom)
    }
    
    func configureMilestoneLabel(with issue: Issue) {
        text = issue.labels.first?.title
    }
    
    private func configure() {
        configureUI()
        configureBorder()
    }
    
    private func configureBorder() {
        drawBorder(color: color, width: 1.5)
        layer.cornerRadius = 8.0
    }

    private func configureUI() {
        text = "milestone"
        textAlignment = .center
        textColor = color
        font = .systemFont(ofSize: titleFontSize, weight: .medium)
    }
}
