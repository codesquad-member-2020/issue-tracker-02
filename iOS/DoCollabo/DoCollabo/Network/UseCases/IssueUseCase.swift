//
//  IssueUseCase.swift
//  DoCollabo
//
//  Created by delma on 2020/06/19.
//  Copyright © 2020 delma. All rights reserved.
//

import Foundation
import Alamofire

final class IssuesUseCase: UseCase {
    var networkDispatcher: NetworkDispatcher = AF
    
    func requestDelete(request: URLRequest, completion: @escaping (Result<Any, NetworkError>) -> ()) {
        networkDispatcher.implement(request: request) { statusCode in
            switch statusCode {
            case 200...202:
                return completion(.success(true))
            case 409:
                return completion(.failure(.AuthorizationDenied))
            default:
                return completion(.failure(.BadRequest))
            }
        }
    }
}
