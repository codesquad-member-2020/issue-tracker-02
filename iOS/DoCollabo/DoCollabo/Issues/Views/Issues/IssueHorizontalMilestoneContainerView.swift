//
//  IssueHorizontalMilestoneContainerView.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/17.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class IssueHorizontalMilestoneContainerView: UIStackView {
    
    private var milestoneLabel: IssueHorizontalMilestoneLabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configureMilestoneLabel(with issue: Issue) {
        milestoneLabel.configureMilestoneLabel(with: issue)
    }
    
    private func configure() {
        configureStackView()
        configureUI()
    }
    
    private func configureStackView() {
        axis = .vertical
        alignment = .leading
        spacing = 0
    }
    
    private func configureUI() {
        milestoneLabel = IssueHorizontalMilestoneLabel()
        addArrangedSubview(milestoneLabel)
    }
}
