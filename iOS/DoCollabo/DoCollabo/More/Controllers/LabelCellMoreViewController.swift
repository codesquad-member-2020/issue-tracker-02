//
//  LabelCellMoreViewController.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/24.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

protocol LabelCellMoreViewControllerDelegate: class {
    func removeLabelCell(at indexPath: IndexPath)
}

final class LabelCellMoreViewController: MoreViewController {
    
    private var editButton: UIButton!
    private var deleteButton: UIButton!
    private var titleLabelView: MoreTitleLabelView!
    
    private var label: IssueLabel!
    private var indexPath: IndexPath!
    private var labelsUseCase: LabelsUseCase!
    
    weak var delegate: LabelCellMoreViewControllerDelegate?
    
    func configureLabelCellMoreViewController(
        with label: IssueLabel,
        labelsUseCase: LabelsUseCase,
        at indexPath: IndexPath) {
        self.label = label
        self.indexPath = indexPath
        self.labelsUseCase = labelsUseCase
        configureButtons()
        configureMoreViewController()
        addOptions(buttons: editButton, deleteButton)
        configureTitle(nil)
        configureTitleViewUI()
        configureTitleView(titleLabelView)
    }
}

// MARK:- Error Handling

extension LabelCellMoreViewController {
    func presentError(_ error: NetworkError) {
        let alertController = NetworkErrorAlertController(
            title: nil,
            message: error.description,
            preferredStyle: .alert)
        alertController.configureDoneAction() { (_) in
            return
        }
        present(alertController, animated: true)
    }
}

// MARK:- Button Actions

extension LabelCellMoreViewController {
    @objc private func editButtonDidTap() {
        
    }
    
    @objc private func deleteButtonDidTap() {
        let alertController = UIAlertController(title: "경고", message: "삭제하시겠습니까?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "예", style: .default) { (_) in
            self.removeLabel()
        }
        let cancelAction = UIAlertAction(title: "아니요", style: .default) { (_) in
            return
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func removeLabel() {
        guard let id = label.id else { return }
        let deleteRequest = LabelsRequest(method: .DELETE, id: String(id)).asURLRequest()
        labelsUseCase.getStatus(request: deleteRequest) { (result) in
            switch result {
            case .success(_):
                self.dismissMoreView()
                self.delegate?.removeLabelCell(at: self.indexPath)
            case .failure(let error):
                self.presentError(error)
            }
        }
    }
}

// MARK:- Configuration

extension LabelCellMoreViewController {
    private func configureTitleViewUI() {
        titleLabelView = MoreTitleLabelView()
        titleLabelView.configureLabel(with: label)
    }
    
    private func configureButtons() {
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
