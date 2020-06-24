//
//  IssueLabel.swift
//  DoCollabo
//
//  Created by delma on 2020/06/10.
//  Copyright © 2020 delma. All rights reserved.
//

import Foundation

struct IssueLabel: Codable {
    private(set) var id: Int?
    private(set) var title: String
    private(set) var colorHexString: String
    private(set) var description: String?
    
    mutating func update(title: String, colorHexString: String, description: String?) {
        self.title = title
        self.colorHexString = colorHexString
        self.description = description
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case colorHexString = "color"
        case description
    }
}
