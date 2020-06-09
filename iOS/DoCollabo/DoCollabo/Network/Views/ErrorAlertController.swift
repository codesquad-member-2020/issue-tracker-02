//
//  ErrorAlertController.swift
//  DoCollabo
//
//  Created by delma on 2020/06/09.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

class ErrorAlertController: UIAlertController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configure(
        actionTitle: String = "확인",
        actionHandler: @escaping (UIAlertAction) -> Void) {
        title = "네트워크 에러"
        configureAction(title: actionTitle, handler: actionHandler)
    }
    
    private func configureAction(title: String, handler: @escaping (UIAlertAction) -> Void) {
        let action = UIAlertAction(title: title, style: .default, handler: handler)
        addAction(action)
    }
}

extension ErrorAlertController {
    func configurePreferredStyle() {
        
    }
}
