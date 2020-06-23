//
//  IssueHorizontalTrailingStackView.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/17.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

protocol IssueHorizontalTrailingStackViewDelegate: class {
    func moreButtonDidTap(_ button: UIButton)
}

final class IssueHorizontalTrailingStackView: UIStackView {

    static let width: CGFloat = 40.0
    
    private var moreButton: IssueMoreButton!
    private var commentsView: IssueHorizontalCommentView!
    
    private let dateLabelFontSize: CGFloat = 14.0
    
    weak var delegate: IssueHorizontalTrailingStackViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configureTrailingStackView(with issue: Issue) {
        commentsView.configureCommentView(with: issue)
    }
}

// MARK:- Configuration

extension IssueHorizontalTrailingStackView {
    private func configure() {
        configureStackView()
        configureUI()
        configureMoreButtonAction()
        configureArrangedSubview()
        configureLayout()
    }
    
    private func configureMoreButtonAction() {
        moreButton.addTarget(self, action: #selector(moreButtonDidTap), for: .touchUpInside)
    }
    
    @objc private func moreButtonDidTap(_ button: UIButton) {
        delegate?.moreButtonDidTap(button)
    }
    
    private func configureStackView() {
        axis = .vertical
        spacing = 0.0
    }
    
    private func configureUI() {
        moreButton = IssueMoreButton()
        commentsView = IssueHorizontalCommentView()
    }
    
    private func configureArrangedSubview() {
        addArrangedSubview(moreButton)
        addArrangedSubview(commentsView)
    }
    
    private func configureLayout() {
        moreButton.constraints(
            topAnchor: nil,
            leadingAnchor: nil,
            bottomAnchor: nil,
            trailingAnchor: nil,
            size: IssueMoreButton.size)
    }
}
