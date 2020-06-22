//
//  IssueLabel.swift
//  DoCollabo
//
//  Created by delma on 2020/06/10.
//  Copyright © 2020 delma. All rights reserved.
//

import Foundation

struct IssueLabel: Codable {
    var id: Int?
    var title: String
    var color: String
    var description: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case color
        case description
    }
}
