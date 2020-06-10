//
//  LabelCollectionViewCell.swift
//  DoCollabo
//
//  Created by delma on 2020/06/10.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

class BadgeCell: UICollectionViewCell {

    @IBOutlet weak var background: UIView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func changeBackground(_ color: UIColor) {
        background.backgroundColor = color
    }
    
    func configureLabel(_ text: String) {
        
    }

}