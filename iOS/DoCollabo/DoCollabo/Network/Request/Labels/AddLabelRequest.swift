//
//  AddLabelRequest.swift
//  DoCollabo
//
//  Created by delma on 2020/06/12.
//  Copyright © 2020 delma. All rights reserved.
//

import Foundation

struct AddLabelRequest: Request {
    var path: String = EndPoint.labels
    var method: HTTPMethod = .POST
}
