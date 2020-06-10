//
//  NetworkManager.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/08.
//  Copyright © 2020 delma. All rights reserved.
//

import Foundation
import AuthenticationServices

final class OAuthNetworkManager {
    private var session: ASWebAuthenticationSession?
    
    func authenticateWithGithub(
        viewController: UIViewController,
        completion: @escaping (Result<String, NetworkError>) -> Void) {
        guard let authURL = URL(string: EndPoint.githubOAuth) else { return }
        let scheme = EndPoint.githubURLScheme
        
        session = ASWebAuthenticationSession(
            url: authURL,
            callbackURLScheme: scheme) { (callbackURL, error) in
                if error != nil {
                    self.session?.cancel()
                    completion(.failure(.AuthenticationFailure))
                }
                guard let callbackURL = callbackURL else { return }
                let urlComponents = URLComponents(string: callbackURL.absoluteString)
                guard let token = urlComponents?.queryItems?.first?.value else { return }
                completion(.success(token))
        }
        session?.presentationContextProvider = viewController as? ASWebAuthenticationPresentationContextProviding
        session?.start()
    }
    
    func authenticateWithApple(completion: @escaping (_ token: String) -> Void) {
        let scheme = "apple.docollabo.app"
        let urlComponents = URLComponents(string: OAuthURLStub.callbackURL.absoluteString)
        guard let token = urlComponents?.queryItems?.first?.value else { return }
        completion(token)
    }
}
