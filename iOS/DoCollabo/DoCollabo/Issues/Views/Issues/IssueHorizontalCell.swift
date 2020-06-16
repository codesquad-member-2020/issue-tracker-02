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
    private var descriptionLabel: IssueHorizontalDescriptionLabel!
    
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
            let label = UILabel()
            label.text = milestone
            label.translatesAutoresizingMaskIntoConstraints = false
            label.heightAnchor.constraint(equalToConstant: 32).isActive = true
            contentsStackView.addArrangedSubview(label)
        }

        if issue.labels.count > 0 {
            let collectionView = IssueLabelsCollectionView()
            collectionView.updateLabels(issue.labels)
            contentsStackView.addArrangedSubview(collectionView)
            layoutIfNeeded()
            let contentHeight = collectionView.contentSize.height
            collectionView.heightAnchor.constraint(equalToConstant: contentHeight).isActive = true
        }
        
        if issue.description != "" {
            descriptionLabel.configureDescriptionLabel(with: issue)
            contentsStackView.addArrangedSubview(descriptionLabel)
        }
    }
    
    private func configure() {
        configureUI()
        configureLayout()
    }
    
    private func configureUI() {
        backgroundColor = .tertiarySystemBackground
        
        titleLabel = IssueHorizontalTitleLabel()
        descriptionLabel = IssueHorizontalDescriptionLabel()
        contentsStackView = IssueHorizontalContentsStackView(arrangedSubviews: [titleLabel])
        
        roundCorner(cornerRadius: 16.0)
        drawShadow(color: .darkGray, offset: CGSize(width: 1, height: 1), radius: 4, opacity: 0.3)
    }
    
    private func configureLayout() {
        addSubview(contentsStackView)
        contentsStackView.constraints(
            topAnchor: topAnchor,
            leadingAnchor: leadingAnchor,
            bottomAnchor: bottomAnchor,
            trailingAnchor: trailingAnchor,
            padding: .init(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    override func prepareForReuse() {
        contentsStackView.subviews.forEach { (subview) in
            contentsStackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        titleLabel.text = "Title"
        contentsStackView.addArrangedSubview(titleLabel)
    }
}
