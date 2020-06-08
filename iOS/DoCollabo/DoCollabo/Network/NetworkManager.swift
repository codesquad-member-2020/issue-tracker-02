//
//  NetworkManager.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/08.
//  Copyright © 2020 delma. All rights reserved.
//

import Foundation
import AuthenticationServices

final class NetworkManager {
    private var session: ASWebAuthenticationSession?
    
    func authenticateGithub(
        viewController: UIViewController,
        completion: @escaping (String) -> Void) {
        let githubURL = "http://52.79.81.75:8080/oauth2/authorization/github"
        guard let authURL = URL(string: githubURL) else { return }
        let scheme = "github.docollabo.app"
        
        session = ASWebAuthenticationSession(
            url: authURL,
            callbackURLScheme: scheme) { (callbackURL, error) in
                if let error = error {
                    // error 처리
                }
                guard let callbackURL = callbackURL else { return }
                let urlComponents = URLComponents(string: callbackURL.absoluteString)
                guard let token = urlComponents?.queryItems?.first?.value else { return }
                completion(token)
        }
        session?.presentationContextProvider = viewController as? ASWebAuthenticationPresentationContextProviding
        session?.start()
    }
}
