//
//  NewIssueViewController.swift
//  DoCollabo
//
//  Created by delma on 2020/06/22.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit
import SwiftyMarkdown

class NewIssueViewController: UIViewController {
    
    @IBOutlet weak var titleHeaderView: TitleHeaderView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var markDownSegmentedControl: UISegmentedControl!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var newIssueAccessoryView: NewIssueAccessoryView!
    
    private var itemSelectionViewController: ItemSelectionViewController!
    private var markdownViewer: SwiftyMarkdown!
    private var originText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        configureUI()
        configureSubViewController()
        configureMarkdownViewer()
        configureDelegates()
    }  
  
    private func configureUI() {
        titleHeaderView.titleLabel.text = "새 이슈"
        titleHeaderView.changeUI(titleSize: 34, backgroundColor: .systemBackground)
        backgroundView.roundCorner(cornerRadius: 16.0)
        backgroundView.drawShadow(color: .black, offset: CGSize(width: 1, height: 1), radius: 4, opacity: 0.3)
    }
  
    private func configureDelegates() {
        newIssueAccessoryView.delegate = self
        itemSelectionViewController.delegate = self
    }
    
    private func configureSubViewController() {
        itemSelectionViewController = storyboard?.instantiateViewController(
            identifier: String(describing: ItemSelectionViewController.self))
    }
    
    private func configureMarkdownViewer() {
        markdownViewer = SwiftyMarkdown(string: "")
    }
    
    @IBAction func switchMarkdownEditor(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            descriptionTextView.isEditable = true
            descriptionTextView.text = originText
            break
        case 1:
            originText = descriptionTextView.text
            descriptionTextView.attributedText = markdownViewer.attributedString(from: descriptionTextView.text)
            descriptionTextView.isEditable = false
        default:
            break
        }
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
        newIssueAccessoryView.generateAssigneeView(users)
    }
    
    func labelSubmitButtonDidTap(_ labels: [IssueLabel]) {
        newIssueAccessoryView.generateLabelView(labels)
    }
    
    func milestoneSubmitButtonDidTap(_ milestones: [Milestone]) {
        newIssueAccessoryView.generateMilestoneView(milestones)
    }
}
