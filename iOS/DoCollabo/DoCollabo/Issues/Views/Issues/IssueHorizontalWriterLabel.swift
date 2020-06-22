//
//  IssueHorizontalWriterLabel.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/20.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class IssueHorizontalWriterLabel: UILabel {

    private let textFont: UIFont = .systemFont(ofSize: 13.0, weight: .regular)
    private let descriptionTextColor: UIColor = UIColor(named: "writer.description")!
    private let userIDTextColor: UIColor = UIColor(named: "writer.userID")!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configureWriterLabel(with issue: Issue) {
        let attributedText = NSMutableAttributedString(
            string: "#\(issue.id) ",
            attributes: [.foregroundColor: descriptionTextColor, .font: textFont])
        let userIDAttributedText = NSAttributedString(
            string: issue.userId,
            attributes: [.foregroundColor: userIDTextColor, .font: textFont])
        let descriptionAttributedText = NSAttributedString(
            string: "에 의해 열렸음",
            attributes: [.foregroundColor: descriptionTextColor, .font: textFont])
        attributedText.append(userIDAttributedText)
        attributedText.append(descriptionAttributedText)
        self.attributedText = attributedText
    }
    
    private func configure() {
        configureUI()
    }

    private func configureUI() {
        numberOfLines = 1
    }
}
