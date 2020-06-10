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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var milestoneView: UIView!
    @IBOutlet weak var badgesCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        roundCorner(cornerRadius: 12.0)
        drawBorder(color: .lightGray, width: 0.5)
        drawShadow(color: .darkGray, offset: CGSize(width: 1, height: 1), radius: 5, opacity: 0.4)
    }
}
