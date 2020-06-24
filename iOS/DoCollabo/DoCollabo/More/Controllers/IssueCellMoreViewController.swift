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
    func removeIssue(at indexPath: IndexPath)
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

// MARK:- Error Handling

extension IssueCellMoreViewController {
    func presentError(_ error: NetworkError) {
        let title = error == .AuthorizationDenied ? "권한 에러" : "네트워크 에러"
        let alertController = NetworkErrorAlertController(
            title: nil,
            message: error.description,
            preferredStyle: .alert)
        alertController.configureTitle(title)
        alertController.configureDoneAction() { (_) in
            return
        }
        present(alertController, animated: true)
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
            case .failure(let error):
                self.presentError(error)
            }
        }
    }
    
    @objc private func editButtonDidTap() {
        let alertController = NetworkErrorAlertController(
            title: nil,
            message: "아직 준비 중인 서비스입니다.",
            preferredStyle: .alert)
        alertController.configureTitle("안내")
        alertController.configureDoneAction() { (_) in
            return
        }
        present(alertController, animated: true)
    }
    
    @objc private func deleteButtonDidTap() {
        let alertController = UIAlertController(title: "경고", message: "삭제하시겠습니까?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "삭제", style: .default) { (_) in
            self.removeIssue()
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { (_) in
            return
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func removeIssue() {
        let request = IssuesRequest(method: .DELETE, id: String(issue.id)).asURLRequest()
        issuesUseCase.requestDelete(request: request) { (result) in
            switch result {
            case .success(_):
                self.dismissMoreView()
                self.delegate?.removeIssue(at: self.indexPath)
            case .failure(let error):
                self.presentError(error)
            }
        }
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
