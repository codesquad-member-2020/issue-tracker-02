//
//  Session+NetworkDispatcher.swift
//  DoCollabo
//
//  Created by delma on 2020/06/10.
//  Copyright © 2020 delma. All rights reserved.
//

import Foundation
import Alamofire

extension Session: NetworkDispatcher {
    func execute(request: URLRequest, handler: @escaping (Result<Data?, Error>) -> Void) {
        self.request(request).validate().response { response in
            switch response.result {
            case .success(let data):
                handler(.success(data))
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
    
    func implement(request: URLRequest, handler: @escaping (Int) -> Void) {
        self.request(request).validate().response { response in
            guard let statusCode = response.response?.statusCode else { return }
            handler(statusCode)
        }
    }
}
