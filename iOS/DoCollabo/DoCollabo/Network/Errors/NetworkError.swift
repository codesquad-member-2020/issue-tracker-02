//
//  NetworkError.swift
//  DoCollabo
//
//  Created by delma on 2020/06/09.
//  Copyright © 2020 delma. All rights reserved.
//

import Foundation

enum NetworkError: Error, CustomStringConvertible {
    case NotFound
    case AuthenticationFailure
    
    var description: String {
        switch self {
        case .NotFound:
            return "네트워크 요청에 실패했습니다."
        case .AuthenticationFailure:
            return "인증에 실패했습니다."
        }
    }
}
