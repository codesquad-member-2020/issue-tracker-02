//
//  NewIssue.swift
//  DoCollabo
//
//  Created by delma on 2020/06/25.
//  Copyright © 2020 delma. All rights reserved.
//

import Foundation

struct NewIssue: Codable {
    private(set) var title: String
    private(set) var description: String
    private(set) var idOfLabels: [Int]?
    private(set) var idOfMilestones: [Int]?
}
