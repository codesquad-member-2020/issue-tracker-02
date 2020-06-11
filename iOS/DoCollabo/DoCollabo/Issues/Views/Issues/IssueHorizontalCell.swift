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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configureCell(with issue: Issue) {
        titleLabel.text = issue.title

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
            collectionView.heightAnchor.constraint(equalToConstant: 36).isActive = true
        }
    }
    
    private func configure() {
        configureUI()
        configureLayout()
    }
    
    private func configureUI() {
        backgroundColor = .white
        
        titleLabel = IssueHorizontalTitleLabel()
        contentsStackView = IssueHorizontalContentsStackView(arrangedSubviews: [titleLabel])
        
        roundCorner(cornerRadius: 12.0)
        drawBorder(color: .lightGray, width: 0.3)
        drawShadow(color: .darkGray, offset: CGSize(width: 1, height: 1), radius: 4, opacity: 0.3)
    }
    
    private func configureLayout() {
        addSubview(contentsStackView)
        contentsStackView.constraints(
            topAnchor: topAnchor,
            leadingAnchor: leadingAnchor,
            bottomAnchor: bottomAnchor,
            trailingAnchor: trailingAnchor,
            padding: .init(top: 12, left: 16, bottom: 12, right: 16),
            size: .init(width: UIScreen.main.bounds.width * 0.8, height: 0))
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
