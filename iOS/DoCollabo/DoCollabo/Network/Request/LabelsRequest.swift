//
//  LabelsRequest.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/16.
//  Copyright © 2020 delma. All rights reserved.
//

import Foundation

struct LabelsRequest: Request {
    var path: String = EndPoint.labels
    var method: HTTPMethod
    
    init(method: HTTPMethod = .GET, id: String? = nil) {
        self.method = method
        guard let id = id else { return }
        path += "/" + id
    }
}
