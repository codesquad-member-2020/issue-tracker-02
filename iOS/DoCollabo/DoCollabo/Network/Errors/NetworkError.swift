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
    case BadRequest
    case AuthenticationFailure
    
    var description: String {
        switch self {
        case .NotFound:
            return "네트워크 요청에 실패했습니다."
        case .BadRequest:
            return "잘못된 요청입니다."
        case .AuthenticationFailure:
            return "인증에 실패했습니다."
        }
    }
}

enum DecodingError: Error, CustomStringConvertible {
    
    case DecodeError
    
    var description: String {
        switch self {
        case .DecodeError:
            return "네트워크 요청에 실패했습니다."
        }
    }
}
