//
//  LabelCellMoreViewController.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/24.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class LabelCellMoreViewController: MoreViewController {
    
    private var editButton: UIButton!
    private var deleteButton: UIButton!
    
    private var label: IssueLabel!
    private var indexPath: IndexPath!
    
    func configureLabelCellMoreViewController(
        with label: IssueLabel,
        at indexPath: IndexPath) {
        self.label = label
        self.indexPath = indexPath
        configureButtons()
        configureMoreViewController()
        addOptions(buttons: editButton, deleteButton)
        configureTitle(label.title)
    }
}

// MARK:- Button Actions

extension LabelCellMoreViewController {
    @objc private func editButtonDidTap() {
        
    }
    
    @objc private func deleteButtonDidTap() {
        
    }
}

// MARK:- Configuration

extension LabelCellMoreViewController {
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
