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
    private var issueUseCase: IssuesUseCase!
    
    private var selectedLabelsID: [Int] = []
    private var selectedMilestonesID: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func requestAddIssue() {
        guard let newIssue = generateNewIssue() else { return }
        encodeNewIssue(newIssue) { encodedData in
            let request = IssuesRequest(method: .POST, id: nil, bodyParams: encodedData).asURLRequest()
            issueUseCase.getStatus(request: request) { result in
                switch result {
                case .success(_):
                    self.dismiss(animated: true)
                case .failure(let error):
                    self.presentErrorAlert(error: error) {
                        self.requestAddIssue()
                    }
                }
            }
        }
    }
    
    private func encodeNewIssue(_ newIssue: NewIssue, completion: (Data) -> Void) {
        do {
            let encodedData = try JSONEncoder().encode(newIssue)
            completion(encodedData)
        } catch {
            self.presentErrorAlert(error: NetworkError.BadRequest) {  }
        }
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

//MARK: - ItemSelectionDelegate

extension NewIssueViewController: ItemSelectionViewDelegate {
    func assigneesSubmitButtonDidTap(_ users: [User]) {
        newIssueAccessoryView.generateAssigneeView(users)
    }
    
    func labelSubmitButtonDidTap(_ labels: [IssueLabel]) {
        newIssueAccessoryView.generateLabelView(labels)
        labels.forEach {
            guard let id = $0.id else { return }
            selectedLabelsID.append(id)
        }
    }
    
    func milestoneSubmitButtonDidTap(_ milestones: [Milestone]) {
        newIssueAccessoryView.generateMilestoneView(milestones)
        milestones.forEach {
            selectedMilestonesID.append($0.id)
        }
    }
}

//MARK: - Configurations

extension NewIssueViewController {
    private func configure() {
        configureUI()
        configureSubViewController()
        configureDelegates()
        configureMarkdownViewer()
        configureUseCase()
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
        titleHeaderView.delegate = self
    }
    
    private func configureSubViewController() {
        itemSelectionViewController = storyboard?.instantiateViewController(
            identifier: String(describing: ItemSelectionViewController.self))
    }
    
    private func configureMarkdownViewer() {
        markdownViewer = SwiftyMarkdown(string: "")
    }
    
    private func configureUseCase() {
        issueUseCase = IssuesUseCase()
    }
}

//MARK: - HeaderViewActionDelegate

extension NewIssueViewController: HeaderViewActionDelegate {
    func newButtonDidTap() {
        validContents() ? requestAddIssue() : nil
    }
    
    private func validContents() -> Bool {
        originText = descriptionTextView.text
        guard titleTextField.text != "" else {
            presentEmptyAlert("제목")
            return false
        }
        guard descriptionTextView.text != "" else {
            presentEmptyAlert("내용")
            return false
        }
        return true
    }
    
    private func presentEmptyAlert(_ content: String) {
        let alert = UIAlertController(title: "알림", message: "\(content)을 반드시 작성해주세요.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default) { _ in }
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    private func generateNewIssue() -> NewIssue? {
        guard let title = titleTextField.text else { return nil }
        let newIssue = NewIssue(title: title, description: originText, idOfLabels: selectedLabelsID, idOfMilestones: selectedMilestonesID)
        return newIssue
    }
}

// MARK:- Error Alert

extension NewIssueViewController {
    private func presentErrorAlert(error: Error, handler: @escaping () -> Void) {
        let alertController = NetworkErrorAlertController(
            title: nil,
            message: error.localizedDescription,
            preferredStyle: .alert)
        alertController.configureAction(title: "재요청") { (_) in
            handler()
        }
        alertController.configureDoneAction() { (_) in
            return
        }
        self.present(alertController, animated: true)
    }
}
