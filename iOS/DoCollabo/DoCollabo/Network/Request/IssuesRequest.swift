//
//  IssuesRequest.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/16.
//  Copyright © 2020 delma. All rights reserved.
//

import Foundation

struct IssuesRequest: Request {
    var path: String = EndPoint.issues
    var method: HTTPMethod
    var bodyParams: Data?
    
    init(method: HTTPMethod = .GET, id: String? = nil, bodyParams: Data? = nil) {
        self.method = method
        self.bodyParams = bodyParams
        guard let id = id else { return }
        path += "/" + id
    }
}
