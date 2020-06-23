//
//  Milestone.swift
//  DoCollabo
//
//  Created by delma on 2020/06/23.
//  Copyright © 2020 delma. All rights reserved.
//

import Foundation

struct Milestone: Codable {
    private(set) var id: Int
    private(set) var issueCount: Int
    private(set) var title: String
    private(set) var dueDate: String
    private(set) var description: String
    private(set) var closeIssueCount: Int
}
