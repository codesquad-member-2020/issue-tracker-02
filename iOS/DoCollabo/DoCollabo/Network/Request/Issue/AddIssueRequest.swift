//
//  AddIssueRequest.swift
//  DoCollabo
//
//  Created by delma on 2020/06/10.
//  Copyright © 2020 delma. All rights reserved.
//

import Foundation

struct AddIssueRequest: Request {
    var path: String = EndPoint.issues
    var method: HTTPMethod = .POST
}
