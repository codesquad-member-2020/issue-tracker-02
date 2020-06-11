//
//  NetworkDispatcher.swift
//  DoCollabo
//
//  Created by delma on 2020/06/10.
//  Copyright © 2020 delma. All rights reserved.
//

import Foundation

protocol NetworkDispatcher {
    func execute(request: URLRequest, handler: @escaping (Data?) -> Void)
}
