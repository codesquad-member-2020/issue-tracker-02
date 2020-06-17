//
//  IssueHorizontalTrailingStackView.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/17.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class IssueHorizontalTrailingStackView: UIStackView {

    static let width: CGFloat = 40.0
    
    private var dateLabel: UILabel!
    private var commentsView: IssueHorizontalCommentView!
    
    private let dateLabelFontSize: CGFloat = 14.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configureTrailingStackView(with issue: Issue) {
        dateLabel.text = "1min"
        commentsView.configureCommentView(with: issue)
        configureArrangedSubview()
    }
    
    private func configure() {
        configureStackView()
        configureUI()
        configureArrangedSubview()
    }
    
    private func configureStackView() {
        axis = .vertical
        spacing = 4.0
    }
    
    private func configureUI() {
        dateLabel = UILabel()
        commentsView = IssueHorizontalCommentView()
        dateLabel.textColor = .lightGray
        dateLabel.font = .systemFont(ofSize: dateLabelFontSize, weight: .medium)
    }
    
    private func configureArrangedSubview() {
        addArrangedSubview(dateLabel)
        addArrangedSubview(commentsView)
    }
}
