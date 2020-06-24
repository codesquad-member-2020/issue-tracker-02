//
//  MoreTitleLabelView.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/24.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class MoreTitleLabelView: UIView {
    
    private var labelBackgroundView: UIView!
    private var labelTextLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configureLabel(with label: IssueLabel) {
        labelTextLabel.text = label.title
        let color = UIColor(hexString: label.colorHexString)
        labelBackgroundView.backgroundColor = color
        labelTextLabel.textColor = color.isDark ? .white : .black
    }
    
    private func configure() {
        configureUI()
        configureLayout()
    }
    
    private func configureUI() {
        backgroundColor = .clear
        labelBackgroundView = UIView()
        labelBackgroundView.roundCorner(cornerRadius: 12.0)
        labelTextLabel = UILabel()
        labelTextLabel.font = .systemFont(ofSize: 14.0, weight: .semibold)
        labelTextLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    private func configureLayout() {
        addSubview(labelBackgroundView)
        labelBackgroundView.addSubview(labelTextLabel)
        labelBackgroundView.constraints(
            topAnchor: topAnchor,
            leadingAnchor: leadingAnchor,
            bottomAnchor: bottomAnchor,
            trailingAnchor: nil)
        labelTextLabel.constraints(
            topAnchor: labelBackgroundView.topAnchor,
            leadingAnchor: labelBackgroundView.leadingAnchor,
            bottomAnchor: labelBackgroundView.bottomAnchor,
            trailingAnchor: labelBackgroundView.trailingAnchor,
            padding: .init(top: 0, left: 12, bottom: 0, right: 12))
    }
}
