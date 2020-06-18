//
//  IssueHorizontalCell.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/09.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class IssueHorizontalCell: UICollectionViewCell {

    static let horizontalPadding: CGFloat = 24.0
    
    private var contentsStackView: UIStackView!
    private var titleLabel: IssueHorizontalTitleLabel!
    private var milestoneView: IssueHorizontalMilestoneContainerView!
    private var issueLabelsViewController: IssueLabelsViewController!
    private var descriptionLabel: IssueHorizontalDescriptionLabel!
    private var trailingStackView: IssueHorizontalTrailingStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configureCell(with issue: Issue) {
        titleLabel.configureTitleLabel(with: issue)

        if let milestone = issue.labels.first?.title {
            milestoneView.configureMilestoneLabel(with: issue)
            contentsStackView.addArrangedSubview(milestoneView)
        }

        if issue.labels.count > 0 {
            issueLabelsViewController.updateLabels(issue.labels)
            contentsStackView.addArrangedSubview(issueLabelsViewController.view)
            layoutIfNeeded()
            issueLabelsViewController.view.heightAnchor.constraint(equalToConstant: issueLabelsViewController.contentHeight).isActive = true
        }
        
        if issue.description != "" {
            descriptionLabel.configureDescriptionLabel(with: issue)
            contentsStackView.addArrangedSubview(descriptionLabel)
        }
        
        trailingStackView.configureTrailingStackView(with: issue)
    }
    
    private func configure() {
        configureUI()
        configureLayout()
    }
    
    private func configureUI() {
        backgroundColor = .tertiarySystemBackground
        
        titleLabel = IssueHorizontalTitleLabel()
        milestoneView = IssueHorizontalMilestoneContainerView()
        issueLabelsViewController = IssueLabelsViewController()
        descriptionLabel = IssueHorizontalDescriptionLabel()
        trailingStackView = IssueHorizontalTrailingStackView()
        contentsStackView = IssueHorizontalContentsStackView(arrangedSubviews: [titleLabel])
        
        roundCorner(cornerRadius: 16.0)
        drawShadow(color: .darkGray, offset: CGSize(width: 1, height: 1), radius: 4, opacity: 0.3)
    }
    
    private func configureLayout() {
        addSubview(contentsStackView)
        addSubview(trailingStackView)
        contentsStackView.constraints(
            topAnchor: topAnchor,
            leadingAnchor: leadingAnchor,
            bottomAnchor: bottomAnchor,
            trailingAnchor: trailingStackView.leadingAnchor,
            padding: .init(top: 16, left: 16, bottom: 16, right: 8))
        trailingStackView.constraints(
            topAnchor: topAnchor,
            leadingAnchor: contentsStackView.trailingAnchor,
            bottomAnchor: nil,
            trailingAnchor: trailingAnchor,
            padding: .init(top: 16, left: 8, bottom: 16, right: 12),
            size: .init(width: IssueHorizontalTrailingStackView.width, height: 0))
    }
    
    override func prepareForReuse() {
        contentsStackView.subviews.forEach { (subview) in
            contentsStackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        titleLabel.text = "Title"
        contentsStackView.addArrangedSubview(titleLabel)
        trailingStackView.subviews.forEach { (subview) in
            contentsStackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
    }
}
