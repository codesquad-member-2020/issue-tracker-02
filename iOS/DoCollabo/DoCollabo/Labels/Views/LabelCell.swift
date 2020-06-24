//
//  LabelCell.swift
//  DoCollabo
//
//  Created by delma on 2020/06/12.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class LabelCell: UICollectionViewCell {
    
    static let height: CGFloat = 56.0
    
    @IBOutlet weak var contentsStackView: UIStackView!
    @IBOutlet weak var labelContainerStackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleBackground: UIView!
    private var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    private func configure() {
        configureUI()
    }
    
    private func configureUI() {
        contentsStackView.spacing = 8
        drawShadow(color: .darkGray, offset: CGSize(width: 1, height: 1), radius: 4, opacity: 0.3)
        roundCorner(cornerRadius: 16.0)
        titleBackground.roundCorner(cornerRadius: 16.0)
        descriptionLabel = LabelDescriptionLabel()
    }
    
    func configureCell(with label: IssueLabel) {
        titleLabel.text = label.title
        let color = UIColor(hexString: label.color)
        titleLabel.textColor = color.isDark ? .white : .black
        titleBackground.backgroundColor = color
        descriptionLabel.text = label.description
        if label.description != "" {
            contentsStackView.addArrangedSubview(descriptionLabel)
        }
    }
    
    override func prepareForReuse() {
        contentsStackView.arrangedSubviews.forEach {
            contentsStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        contentsStackView.addArrangedSubview(labelContainerStackView)
    }
}
