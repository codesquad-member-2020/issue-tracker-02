//
//  IssueCellMoreViewController.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/23.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

protocol IssueCellMoreViewControllerDelegate: class {
    func issueStatusToggleButtonDidTap()
    func editButtonDidTap()
    func deleteButtonDidTap()
}

final class IssueCellMoreViewController: MoreViewController {
    
    private var issueStatusToggleButton: UIButton!
    private var editButton: UIButton!
    private var deleteButton: UIButton!
    
    weak var delegate: IssueCellMoreViewControllerDelegate?
    
    private var issue: Issue!
    private var issuesUseCase: IssuesUseCase!
    
    func configureIssueCellMoreViewController(with issue: Issue, issuesUseCase: IssuesUseCase) {
        self.issue = issue
        self.issuesUseCase = issuesUseCase
        configureButtons()
        configureMoreViewController()
        addOptions(buttons: issueStatusToggleButton, editButton, deleteButton)
        configureTitle(issue.title)
    }
}

// MARK:- Button Actions

extension IssueCellMoreViewController {
    @objc private func issueStatusToggleButtonDidTap() {
        
        delegate?.issueStatusToggleButtonDidTap()
    }
    
    @objc private func editButtonDidTap() {
        delegate?.editButtonDidTap()
    }
    
    @objc private func deleteButtonDidTap() {
        delegate?.deleteButtonDidTap()
    }
}

// MARK:- Configuration

extension IssueCellMoreViewController {
    private func configureButtons() {
        let issueStatusToggleButtonTitle = issue.close ? "이슈 다시 열기" : "이슈 닫기"
        issueStatusToggleButton = generateButton(
            title: "\(issueStatusToggleButtonTitle)",
            target: self,
            action: #selector(issueStatusToggleButtonDidTap),
            for: .touchUpInside)
        editButton = generateButton(
            title: "수정하기",
            target: self,
            action: #selector(editButtonDidTap),
            for: .touchUpInside)
        deleteButton = generateButton(
            title: "삭제하기",
            target: self,
            action: #selector(deleteButtonDidTap),
            for: .touchUpInside)
    }
}
