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
        button.setTitleColor(UIColor(named: "key.navy"), for: .normal)
        return button
    }
    
    func cancelButton() -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        return button
    }
    
}
