//
//  DeleteLabelRequest.swift
//  DoCollabo
//
//  Created by delma on 2020/06/12.
//  Copyright © 2020 delma. All rights reserved.
//

import Foundation

struct DeleteLabelRequest: Request {
    var id: String
    var path: String = EndPoint.labels
    var method: HTTPMethod = .DELETE
    
    init(id: String) {
        self.id = id
        path += "/" + id
    }
}
