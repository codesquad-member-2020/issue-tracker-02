//
//  EndPoint.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/09.
//  Copyright © 2020 delma. All rights reserved.
//

import Foundation

enum EndPoint {
    static let baseURL: String = "http://52.79.81.75:8080"
    static let githubOAuth: String = "\(Self.baseURL)/oauth2/authorization/github"
    static let githubURLScheme: String = "github.docollabo.app"
    static let issues: String = "\(Self.baseURL)/api/issues"
    static let labels: String = "\(Self.baseURL)/api/labels"
    static let milestones: String = "\(Self.baseURL)/api/milestones"
}
