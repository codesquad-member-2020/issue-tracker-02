//
//  DeleteIssueRequest.swift
//  DoCollabo
//
//  Created by delma on 2020/06/10.
//  Copyright © 2020 delma. All rights reserved.
//

import Foundation

struct DeleteIssueRequest: Request {
    var id: String
    var path: String = EndPoint.issues
    var method: HTTPMethod = .DELETE
    
    init(id: String) {
        self.id = id
        path += "/" + id
    }
}
