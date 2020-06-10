//
//  IssueHorizontalCell.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/09.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class IssueHorizontalCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var milestoneView: UIView!
    @IBOutlet weak var badgesCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
