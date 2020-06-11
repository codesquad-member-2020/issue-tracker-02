//
//  ViewModelBinding.swift
//  DoCollabo
//
//  Created by delma on 2020/06/11.
//  Copyright © 2020 delma. All rights reserved.
//

import Foundation

protocol ViewModelBinding {
    associatedtype Key
    typealias handler = (Key) -> Void
    func updateNotify(handler: @escaping handler)
}
