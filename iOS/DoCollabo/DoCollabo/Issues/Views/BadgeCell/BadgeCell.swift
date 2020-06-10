//
//  LabelCollectionViewCell.swift
//  DoCollabo
//
//  Created by delma on 2020/06/10.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class BadgeCell: UICollectionViewCell {

    static let horizontalPadding: CGFloat = 18.0
    static let verticalPadding: CGFloat = 10.0
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureLabel(_ text: String) {
        label.text = text
    }
}
