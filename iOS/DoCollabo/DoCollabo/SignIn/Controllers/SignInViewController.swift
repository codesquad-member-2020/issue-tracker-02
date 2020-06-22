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
    
    private var networkManager: OAuthNetworkManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager = OAuthNetworkManager()
    }
}

// MARK:- Button Actions

extension SignInViewController {
    @IBAction func signInWithGithubButtonDidTap(_ sender: LeadingImageButton) {
        networkManager.authenticateWithGithub(viewController: self) { result in
            switch result {
            case .success(let token):
                UserDefaults.standard.set(token, forKey: OAuthNetworkManager.jwtToken)
                self.dismiss(animated: true, completion: nil)
            case .failure(let error):
                self.presentErrorAlert(error: error)
            }
        }
    }
    
    @IBAction func signInWithAppleButtonDidTap(_ sender: UIButton) {
       let request = ASAuthorizationAppleIDProvider().createRequest()
       request.requestedScopes = [.email, .fullName]
       let controller = ASAuthorizationController(authorizationRequests: [request])
       controller.delegate = self
       controller.presentationContextProvider = self
       controller.performRequests()
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

// MARK:- ASAuthorizationControllerPresentationContextProviding

extension SignInViewController: ASAuthorizationControllerPresentationContextProviding {
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
        guard let token = credential.identityToken else { return }
        guard let jwt = String(data: token, encoding: .utf8) else { return }
        UserDefaults.standard.set(jwt, forKey: OAuthNetworkManager.jwtToken)
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK:- ASWebAuthenticationPresentationContextProviding

extension SignInViewController: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return view.window!
    }
}

// MARK:- ASAuthorizationControllerDelegate

extension SignInViewController: ASAuthorizationControllerDelegate {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
