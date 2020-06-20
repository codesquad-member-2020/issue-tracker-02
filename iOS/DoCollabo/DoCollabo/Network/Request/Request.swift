//
//  Request.swift
//  DoCollabo
//
//  Created by delma on 2020/06/10.
//  Copyright © 2020 delma. All rights reserved.
//

import Foundation
import Alamofire

enum HTTPMethod: String {
    case GET, POST, PUT, PATCH, DELETE
}

protocol Request {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var bodyParams: Data? { get }
    func setToken() -> HTTPHeaders?
    func asURLRequest() -> URLRequest
}

extension Request {
    var method: HTTPMethod { return .GET }
    var headers: HTTPHeaders? { return nil }
    var bodyParams: Data? { return nil }
    func setToken() -> HTTPHeaders? {
        guard let token = UserDefaults.standard.object(forKey: OAuthNetworkManager.jwtToken) as? String else { return nil }
        let headers: HTTPHeaders = ["Authorization": token]
        return headers
    }
    
    func asURLRequest() -> URLRequest {
        var request = URLRequest(url: URL(string: path)!)
        request.httpMethod = self.method.rawValue
        guard let headersWithToken = setToken() else { return request }
        request.headers = headersWithToken
        guard let bodyParameter = bodyParams else { return request }
        request.httpBody = bodyParameter
        return request
    }
}
