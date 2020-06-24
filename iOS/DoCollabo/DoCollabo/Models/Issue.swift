//
//  Issues.swift
//  DoCollabo
//
//  Created by delma on 2020/06/10.
//  Copyright © 2020 delma. All rights reserved.
//

import Foundation

struct Issue: Codable {
    private(set) var id: Int
    private(set) var isClosed: Bool
    private(set) var title: String
    private(set) var description: String
    private(set) var createdAt: String
    private(set) var updateTimeAt: String
    private(set) var userId: String
    private(set) var labels: [IssueLabel]
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, createdAt, updateTimeAt, userId, labels
        case isClosed = "close"
    }
    
    mutating func updateStatus(isClosed: Bool) {
        self.isClosed = isClosed
    }
}
