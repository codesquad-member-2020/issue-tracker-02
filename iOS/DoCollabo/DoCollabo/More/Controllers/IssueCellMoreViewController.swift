//
//  IssueCellMoreViewController.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/23.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

protocol IssueCellMoreViewControllerDelegate: class {
    func issueStatusDidChange(isClosed: Bool, at indexPath: IndexPath)
    func editButtonDidTap()
    func deleteButtonDidTap()
}

final class IssueCellMoreViewController: MoreViewController {
    
    struct IssueStatus: Encodable {
        let isClosed: Bool
        
        enum CodingKeys: String, CodingKey {
            case isClosed = "close"
        }
    }
    
    private var issueStatusToggleButton: UIButton!
    private var editButton: UIButton!
    private var deleteButton: UIButton!
    
    weak var delegate: IssueCellMoreViewControllerDelegate?
    
    private var issue: Issue!
    private var indexPath: IndexPath!
    private var issuesUseCase: IssuesUseCase!
    
    func configureIssueCellMoreViewController(
        with issue: Issue,
        issuesUseCase: IssuesUseCase,
        at indexPath: IndexPath) {
        self.issue = issue
        self.indexPath = indexPath
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
        let issueStatus = IssueStatus(isClosed: !issue.isClosed)
        guard let encodedData = try? JSONEncoder().encode(issueStatus) else { return }
        let request = IssuesRequest(
            method: .PATCH,
            id: String(issue.id),
            bodyParams: encodedData).asURLRequest()
        issuesUseCase.getStatus(request: request) { (result) in
            switch result {
            case .success(_):
                self.dismissMoreView()
                self.delegate?.issueStatusDidChange(isClosed: !self.issue.isClosed, at: self.indexPath)
            case .failure(_):
                // error handling
                break
            }
        }
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
        let issueStatusToggleButtonTitle = issue.isClosed ? "이슈 다시 열기" : "이슈 닫기"
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
