//
//  IssuesViewController.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/08.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class IssuesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkToken()
    }
    
    private func checkToken() {
        guard let token = UserDefaults.standard.object(forKey: .jwtToken) as? String
        else {
            presentSignIn()
            return
        }
    }
    
    private func presentSignIn() {
        guard let singInViewController = storyboard?.instantiateViewController(
            identifier: String(describing: SignInViewController.self))
        else {
            return
        }
        singInViewController.modalPresentationStyle = .fullScreen
        present(singInViewController, animated: true, completion: nil)
    }
}

extension String {
    static let jwtToken: String = "jwtToken"
}
