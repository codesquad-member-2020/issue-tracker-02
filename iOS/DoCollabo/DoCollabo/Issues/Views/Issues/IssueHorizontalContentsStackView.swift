//
//  IssueHorizontalContentsStackView.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/11.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class IssueHorizontalContentsStackView: UIStackView {
    
    private var titleLabel: IssueHorizontalTitleLabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configureContentsStackView(with issue: Issue) {
        titleLabel.configureTitleLabel(with: issue)
    }
    
    func prepareForReuse() {
        subviews.forEach { (subview) in
            removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        configureDefaultSubviews()
    }
}

// MARK:- Configuration

extension IssueHorizontalContentsStackView {
    private func configure() {
        configureStackView()
        configureUI()
        configureDefaultSubviews()
    }
    
    private func configureDefaultSubviews() {
        addArrangedSubview(titleLabel)
    }
    
    private func configureStackView() {
        axis = .vertical
        spacing = 8
        distribution = .fill
    }
    
    private func configureUI() {
        titleLabel = IssueHorizontalTitleLabel()
    }
}
