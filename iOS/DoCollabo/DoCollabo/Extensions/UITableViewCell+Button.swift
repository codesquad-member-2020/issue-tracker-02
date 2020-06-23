//
//  UITableViewCell+Button.swift
//  DoCollabo
//
//  Created by delma on 2020/06/22.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

extension UITableViewCell {
    func addButton() -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        button.tintColor = UIColor(named: "key.navy")
        button.sizeToFit()
        return button
    }
    
    func cancelButton() -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .lightGray
        button.sizeToFit()
        return button
    }
    
}
