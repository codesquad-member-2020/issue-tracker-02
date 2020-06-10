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
    
    @IBOutlet weak var labelBackgroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = .systemFont(ofSize: Self.titleFontSize, weight: .semibold)
        roundCorner(cornerRadius: 6.0)
    }
    
    func configureLabel(text: String, color: UIColor) {
        titleLabel.text = text
        labelBackgroundView.backgroundColor = color
    }
}
