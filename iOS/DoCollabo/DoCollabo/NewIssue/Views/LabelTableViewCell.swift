//
//  LabelTableViewCell.swift
//  DoCollabo
//
//  Created by delma on 2020/06/23.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

class LabelTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelBackground: UIView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        labelTitle.text = ""
        labelBackground.backgroundColor = .clear
    }
    
    func configureData(_ label: IssueLabel) {
        let color = UIColor(hexString: label.color)
        var textColor: UIColor = .black
        color.isDark ? textColor = .white : nil
        labelTitle.text = label.title
        labelTitle.textColor = textColor
        labelBackground.backgroundColor = color
        labelBackground.roundCorner(cornerRadius: 16.0)
    }
}
