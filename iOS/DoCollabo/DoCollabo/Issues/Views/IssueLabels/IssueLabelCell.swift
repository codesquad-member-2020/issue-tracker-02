//
//  IssueLabelCell.swift
//  DoCollabo
//
//  Created by delma on 2020/06/10.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class IssueLabelCell: UICollectionViewCell {

    static let horizontalPadding: CGFloat = 18.0
    static let verticalPadding: CGFloat = 10.0
    static let titleFontSize: CGFloat = 14.0
    static let cornerRadius: CGFloat = 6.0
    
    @IBOutlet weak var labelBackgroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = .systemFont(ofSize: Self.titleFontSize, weight: .semibold)
        roundCorner(cornerRadius: Self.cornerRadius)
    }
    
    func configureLabel(with label: IssueLabel) {
        titleLabel.text = label.title
        let color = UIColor(hexString: label.color)
        titleLabel.textColor = color.isDark ? .white : .black
        labelBackgroundView.backgroundColor = color
    }
}
