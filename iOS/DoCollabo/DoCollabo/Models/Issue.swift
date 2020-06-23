//
//  Issues.swift
//  DoCollabo
//
//  Created by delma on 2020/06/10.
//  Copyright © 2020 delma. All rights reserved.
//

import Foundation

struct Issue: Codable {
    var id: Int
    var isClosed: Bool
    var title: String
    var description: String
    var createdAt: String
    var updateTimeAt: String
    var userId: String
    var labels: [IssueLabel]
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, createdAt, updateTimeAt, userId, labels
        case isClosed = "close"
    }
}
