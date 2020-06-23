//
//  IssuesCollectionViewDataSource.swift
//  DoCollabo
//
//  Created by delma on 2020/06/11.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class IssuesCollectionViewDataSource: NSObject, UICollectionViewDataSource, ViewModelBinding {

    typealias Key = [Issue]
    private var changedHandler: handler
    private var issues: [Issue] {
        didSet {
            changedHandler(issues)
        }
    }
    
    init(issues: [Issue] = [], changedHandler: @escaping handler = { _ in }) {
        self.issues = issues
        self.changedHandler = changedHandler
    }
    
    func referIssue(at indexPath: IndexPath, handler: (Issue) -> Void) {
        let issue = issues[indexPath.item]
        handler(issue)
    }
    
    func updateNotify(handler: @escaping ([Issue]) -> Void) {
        self.changedHandler = handler
    }
    
    func updateIssues(_ issues: [Issue]) {
        self.issues = issues
    }
    
    func updateIssueStatus(isClosed: Bool, at indexPath: IndexPath) {
        issues[indexPath.item].updateStatus(isClosed: isClosed)
    }
    
    func removeIssue(at indexPath: IndexPath) {
        issues.remove(at: indexPath.item)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        return issues.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: IssueHorizontalCell.self),
            for: indexPath) as! IssueHorizontalCell
        let issue = issues[indexPath.item]
        cell.configureCell(with: issue)
        return cell
    }
}
