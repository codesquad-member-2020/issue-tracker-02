//
//  LabelRequest.swift
//  DoCollabo
//
//  Created by delma on 2020/06/19.
//  Copyright © 2020 delma. All rights reserved.
//

import Foundation

struct LabelsRequest: Request {
    var path: String = EndPoint.labels
    var method: HTTPMethod
    var bodyParams: Data?
    init(method: HTTPMethod = .GET, id: String? = nil, bodyParams: Data? = nil) {
        self.method = method
        self.bodyParams = bodyParams
        guard let id = id else { return }
        path += "/" + id
    }
}
