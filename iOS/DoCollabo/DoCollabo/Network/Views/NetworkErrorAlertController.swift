//
//  ErrorAlertController.swift
//  DoCollabo
//
//  Created by delma on 2020/06/09.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class NetworkErrorAlertController: UIAlertController {
    
    private var titleText: String = "네트워크 에러"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleText
    }
    
    func configureAction(title: String, handler: @escaping (UIAlertAction) -> Void) {
        let action = UIAlertAction(title: title, style: .default, handler: handler)
        addAction(action)
    }
    
    func configureDoneAction(handler: @escaping (UIAlertAction) -> Void) {
        configureAction(title: "확인", handler: handler)
    }
    
    func configureTitle(_ title: String) {
        titleText = title
    }
}
