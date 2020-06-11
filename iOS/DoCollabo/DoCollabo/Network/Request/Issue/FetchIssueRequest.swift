//
//  FetchIssueRequest.swift
//  DoCollabo
//
//  Created by delma on 2020/06/10.
//  Copyright © 2020 delma. All rights reserved.
//

import Foundation

struct FetchIssueRequest: Request {
    var id: String
    var path: String = EndPoint.issues
    
    init(id: String) {
        self.id = id
        path += "/" + id
    }
}
