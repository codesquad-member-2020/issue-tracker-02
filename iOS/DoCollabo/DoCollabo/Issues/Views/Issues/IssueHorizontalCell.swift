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
    
    private enum Metric {
        static let topPadding: CGFloat = 16.0
        static let statusImageViewLeft: CGFloat = 12.0
        static let interSpacingForItems: CGFloat = 8.0
        static let contentsStackViewBottom: CGFloat = 16.0
        static let trailingStackViewRight: CGFloat = 16.0
    }
    
    private var statusImageView: IssueStatusImageView!
    private var contentsStackView: IssueHorizontalContentsStackView!
    private var issueLabelsViewController: IssueLabelsViewController!
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
        statusImageView.configureStatusImageView(with: issue)
        contentsStackView.configureContentsStackView(with: issue)

        if issue.labels.count > 0 {
            issueLabelsViewController.updateLabels(issue.labels)
            issueLabelsViewController.reloadCollectionView()
            contentsStackView.addArrangedSubview(issueLabelsViewController.view)
            layoutIfNeeded()
            issueLabelsViewController.view.heightAnchor.constraint(equalToConstant: issueLabelsViewController.contentHeight).isActive = true
        }
        
        trailingStackView.configureTrailingStackView(with: issue)
    }
    
    override func prepareForReuse() {
        contentsStackView.prepareForReuse()
    }
}

// MARK:- Configuration Privately

extension IssueHorizontalCell {
    private func configure() {
        configureUI()
        configureLayout()
    }
    
    private func configureUI() {
        backgroundColor = .tertiarySystemBackground
        
        statusImageView = IssueStatusImageView()
        
        issueLabelsViewController = IssueLabelsViewController()
        trailingStackView = IssueHorizontalTrailingStackView()
        contentsStackView = IssueHorizontalContentsStackView()
        
        roundCorner(cornerRadius: 16.0)
        drawShadow(color: .darkGray, offset: CGSize(width: 1, height: 1), radius: 4, opacity: 0.3)
    }
    
    private func configureLayout() {
        addSubview(statusImageView)
        addSubview(contentsStackView)
        addSubview(trailingStackView)
        statusImageView.constraints(
            topAnchor: topAnchor,
            leadingAnchor: leadingAnchor,
            bottomAnchor: nil,
            trailingAnchor: contentsStackView.leadingAnchor,
            padding: .init(
                top: Metric.topPadding,
                left: Metric.statusImageViewLeft,
                bottom: 0,
                right: Metric.interSpacingForItems),
            size: IssueStatusImageView.size)
        contentsStackView.constraints(
            topAnchor: topAnchor,
            leadingAnchor: statusImageView.trailingAnchor,
            bottomAnchor: bottomAnchor,
            trailingAnchor: trailingStackView.leadingAnchor,
            padding: .init(
                top: Metric.topPadding,
                left: Metric.interSpacingForItems,
                bottom: Metric.contentsStackViewBottom,
                right: Metric.interSpacingForItems))
        trailingStackView.constraints(
            topAnchor: topAnchor,
            leadingAnchor: contentsStackView.trailingAnchor,
            bottomAnchor: nil,
            trailingAnchor: trailingAnchor,
            padding: .init(
                top: Metric.topPadding - 2,
                left: Metric.interSpacingForItems,
                bottom: 0,
                right: Metric.trailingStackViewRight),
            size: .init(width: IssueHorizontalTrailingStackView.width, height: 0))
    }
}
