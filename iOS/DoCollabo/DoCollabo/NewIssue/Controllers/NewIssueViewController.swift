//
//  NewIssueViewController.swift
//  DoCollabo
//
//  Created by delma on 2020/06/22.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

class NewIssueViewController: UIViewController {
    
    @IBOutlet weak var titleHeaderView: TitleHeaderView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var markDownSegmentedControl: UISegmentedControl!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var newIssueAccessoryView: NewIssueAccessoryView!
    
    private var itemSelectionViewController: ItemSelectionViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        configureUI()
        configureSubViewController()
        newIssueAccessoryView.delegate = self
        itemSelectionViewController.delegate = self
    }
    
    private func configureUI() {
        titleHeaderView.titleLabel.text = "새 이슈"
        titleHeaderView.changeUI(titleSize: 34, backgroundColor: .white)
        backgroundView.roundCorner(cornerRadius: 16.0)
        backgroundView.drawShadow(color: .black, offset: CGSize(width: 1, height: 1), radius: 4, opacity: 0.3)
    }
    
    private func configureSubViewController() {
        itemSelectionViewController = storyboard?.instantiateViewController(
            identifier: String(describing: ItemSelectionViewController.self))
    }
}

//MARK:- NewIssueAccessoryDelegate

extension NewIssueViewController: NewIssueAccessoryDelegate {
    func selectAssigneeButtonDidTap() {
        present(itemSelectionViewController, animated: true)
        itemSelectionViewController.fetchAssigneeStub()
    }
    
    func selectLabelsButtonDidTap() {
        present(itemSelectionViewController, animated: true)
        itemSelectionViewController.fetchLabels()
    }
    
    func selectMilestoneButtonDidTap() {
        present(itemSelectionViewController, animated: true)
        itemSelectionViewController.fetchMilestones()
    }
}

extension NewIssueViewController: ItemSelectionViewDelegate {
    func assigneesSubmitButtonDidTap(_ users: [User]) {
        newIssueAccessoryView.makeAssigneeView(users)
    }
    
    func labelSubmitButtonDidTap(_ labels: [IssueLabel]) {
        newIssueAccessoryView.makeLabelView(labels)
    }
    
    func milestoneSubmitButtonDidTap(_ milestones: [Milestone]) {
        newIssueAccessoryView.makeMilestoneView(milestones)
    }
}
