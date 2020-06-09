//
//  SignInViewController.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/08.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit
import AuthenticationServices

final class SignInViewController: UIViewController {

    private var networkManager: NetworkManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networkManager = NetworkManager()
        configureGradientLayer()
    }
}

// MARK:- Button Actions

extension SignInViewController {
    @IBAction func signInWithGithubButtonDidTap(_ sender: LeadingImageButton) {
        networkManager.authenticateWithGithub(viewController: self) { result in
            switch result {
            case .success(let token):
                UserDefaults.standard.set(token, forKey: .jwtToken)
                self.dismiss(animated: true, completion: nil)
            case .failure(let error):
                self.presentErrorAlert(error: error)
            }
        }
    }
    
    @IBAction func signInWithAppleButtonDidTap(_ sender: LeadingImageButton) {
        networkManager.authenticateWithApple { (token) in
            UserDefaults.standard.set(token, forKey: .jwtToken)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func presentErrorAlert(error: NetworkError) {
        let alertController = ErrorAlertController(
            title: nil,
            message: error.description,
            preferredStyle: .alert)
        alertController.configure() { _ in
            return
        }
        self.present(alertController, animated: true)
    }
}

// MARK:- ASWebAuthenticationPresentationContextProviding

extension SignInViewController: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return view.window!
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
