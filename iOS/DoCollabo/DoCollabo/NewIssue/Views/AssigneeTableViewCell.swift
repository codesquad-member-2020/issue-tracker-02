//
//  AssigneeTableViewCell.swift
//  DoCollabo
//
//  Created by delma on 2020/06/22.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

class AssigneeTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userIDLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureData(_ data: User) {
        userIDLabel.text = data.userID
    }
}
