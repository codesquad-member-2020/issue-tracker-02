//
//  IssueUseCase.swift
//  DoCollabo
//
//  Created by delma on 2020/06/10.
//  Copyright © 2020 delma. All rights reserved.
//

import Foundation

struct IssueUseCase {
    var request: URLRequest
    var networkDispatcher: NetworkDispatcher
    
    init(request: URLRequest, networkDispatcher: NetworkDispatcher) {
        self.request = request
        self.networkDispatcher = networkDispatcher
    }
    
    func perform<T: Codable>(dataType: T.Type, handler: @escaping (T) -> ()) {
      networkDispatcher.execute(request: request) { (data) in
        guard let data = data else { return }
        guard let decodedData = try? JSONDecoder().decode(dataType, from: data) else { return }
        handler(decodedData)
      }
    }
}
