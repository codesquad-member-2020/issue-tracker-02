//
//  SignInViewController.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/08.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureGradientLayer()
    }
}

// MARK:- UI Configuration

extension SignInViewController {
    private func configureGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [Colors.keyBlue.cgColor, Colors.keyGreen.cgColor]
        gradientLayer.frame = view.frame
        gradientLayer.locations = [0, 1]
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
