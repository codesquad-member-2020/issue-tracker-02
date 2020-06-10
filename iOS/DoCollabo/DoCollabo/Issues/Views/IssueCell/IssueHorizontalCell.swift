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
    private var milestoneView: UIView!
    private var badgesCollectionView: BadgesCollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configureCell(title: String, milestone: String? = nil, issueLabels: [String]? = nil) {
        titleLabel.text = title
        
        if let milestone = milestone {
            let label = UILabel()
            label.text = milestone
            label.translatesAutoresizingMaskIntoConstraints = false
            label.heightAnchor.constraint(equalToConstant: 32).isActive = true
            contentsStackView.addArrangedSubview(label)
        }
        
        if let issueLabels = issueLabels {
            let collectionView = BadgesCollectionView()
            collectionView.badges = issueLabels
            collectionView.fillSuperview()
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
        drawBorder(color: .lightGray, width: 0.5)
        drawShadow(color: .darkGray, offset: CGSize(width: 1, height: 1), radius: 5, opacity: 0.4)
    }
    
    private func configureLayout() {
        addSubview(contentsStackView)
        contentsStackView.constraints(
            topAnchor: topAnchor,
            leadingAnchor: leadingAnchor,
            bottomAnchor: bottomAnchor,
            trailingAnchor: trailingAnchor,
            padding: .init(top: 8, left: 12, bottom: 8, right: 12))
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
