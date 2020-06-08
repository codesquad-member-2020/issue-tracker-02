//
//  NetworkManager.swift
//  DoCollabo
//
//  Created by delma on 2020/06/08.
//  Copyright © 2020 delma. All rights reserved.
//

import Foundation

final class MockNetworkManager {
    static func authenticateWithGithub(completion: @escaping (_ token: String) -> Void) {
        let scheme = "github.docollabo.app"
        let urlComponents = URLComponents(string: OAuthURLStub.callbackURL.absoluteString)
        guard let token = urlComponents?.queryItems?.first?.value else { return }
        completion(token)
    }
}
