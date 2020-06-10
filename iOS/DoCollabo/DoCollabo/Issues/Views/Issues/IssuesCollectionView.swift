//
//  IssuesCollectionView.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/09.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class IssuesCollectionView: UICollectionView {
    
    struct fakeIssue {
        let title: String
        let milestone: String?
        let labels: [String]?
    }
    
    private let issuesStub = [
        fakeIssue(title: "title1", milestone: "milestone", labels: ["nil", "iOS", "refactoring", "document", "feat"]),
        fakeIssue(title: "title1", milestone: "milestone", labels: nil),
        fakeIssue(title: "title1", milestone: nil, labels: nil),
        fakeIssue(title: "title1", milestone: "milestone", labels: ["nil", "iOS", "refactoring", "document", "feat"]),
        fakeIssue(title: "title1", milestone: "milestone", labels: nil),
        fakeIssue(title: "title1", milestone: nil, labels: nil),
        fakeIssue(title: "title1", milestone: "milestone", labels: nil),
        fakeIssue(title: "title1", milestone: "milestone", labels: ["nil", "iOS", "refactoring", "document", "feat"]),
        fakeIssue(title: "title1", milestone: "milestone", labels: nil),
        fakeIssue(title: "title1", milestone: nil, labels: nil),
        fakeIssue(title: "title1", milestone: "milestone", labels: nil),
        fakeIssue(title: "title1", milestone: nil, labels: ["iOS", "feat"])
    ]

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        registerCollectionViewCell()
        showsVerticalScrollIndicator = false
        dataSource = self
    }
    
    private func registerCollectionViewCell() {
        register(
            IssueHorizontalCell.self,
            forCellWithReuseIdentifier: String(describing: IssueHorizontalCell.self))
    }
}

extension IssuesCollectionView: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        return issuesStub.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: IssueHorizontalCell.self),
            for: indexPath) as! IssueHorizontalCell
        cell.widthAnchor.constraint(
            equalToConstant: collectionView.frame.width * 0.87).isActive = true
        let issue = issuesStub[indexPath.item]
        cell.configureCell(
            title: issue.title,
            milestone: issue.milestone,
            issueLabels: issue.labels)
        return cell
    }
}
