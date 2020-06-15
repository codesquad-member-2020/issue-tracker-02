//
//  LabelCell.swift
//  DoCollabo
//
//  Created by delma on 2020/06/12.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class LabelCell: UICollectionViewCell {
    
    static let height: CGFloat = 84.0
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleBackground: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    private func configure() {
        configureUI()
    }
    
    private func configureUI() {
        drawShadow(color: .darkGray, offset: CGSize(width: 1, height: 1), radius: 4, opacity: 0.3)
        background.roundCorner(cornerRadius: 8.0)
        titleBackground.roundCorner(cornerRadius: IssueLabelCell.cornerRadius)
        descriptionLabel.textColor = .label
        background.backgroundColor = .tertiarySystemBackground
    }
    
    func configureCell(with label: IssueLabel) {
        titleLabel.text = label.title
        let color = UIColor(hexString: label.color)
        titleLabel.textColor = color.isDark() ? .white : .black
        titleBackground.backgroundColor = color
        descriptionLabel.text = label.description
    }
}
