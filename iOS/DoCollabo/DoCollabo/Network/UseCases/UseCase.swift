//
//  UseCase.swift
//  DoCollabo
//
//  Created by delma on 2020/06/10.
//  Copyright © 2020 delma. All rights reserved.
//

import Foundation

protocol UseCase {
    var networkDispatcher: NetworkDispatcher { get set }
    
    func getResources<T: Codable>(
        request: URLRequest,
        dataType: T.Type,
        completion: @escaping (Result<T, Error>) -> ())
}

extension UseCase {
    func getResources<T: Codable>(
        request: URLRequest,
        dataType: T.Type,
        completion: @escaping (Result<T, Error>) -> ()) {
        networkDispatcher.execute(request: request) { (result) in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                guard let decodedData = try? JSONDecoder().decode(dataType, from: data) else {
                    completion(.failure(DecodingError.DecodeError))
                    return
                }
                completion(.success(decodedData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
