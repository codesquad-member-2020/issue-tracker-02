//
//  ItemSelectionViewController.swift
//  DoCollabo
//
//  Created by delma on 2020/06/22.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class ItemSelectionViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var itemSelectionTableView: UITableView!
    
    private var dataSource: UITableViewDataSource!
    private var labelUseCase: LabelsUseCase!
    private var milestoneUseCase: MilestoneUseCase!

    private var selectedUsers: [User]!
    private var selectedLabels: [IssueLabel]!
    private var selectedMilestones: [Milestone]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func fetchAssigneeStub() {
        let stubUsers = AssigneesStub.users
        selectedUsers = []
        assigneeDidLoad(stubUsers)
    }
    
    func fetchMilestones() {
        let request = MilestoneRequest().asURLRequest()
        milestoneUseCase.getResources(request: request, dataType: [Milestone].self) { (result) in
            switch result {
            case .success(let milestones):
                self.selectedMilestones = []
                self.milestoneDidLoad(milestones)
            case .failure(let error):
                self.presentErrorAlert(error: error) {
                    self.fetchMilestones()
                }
            }
        }
    }
    
    func fetchLabels() {
        let request = LabelsRequest().asURLRequest()
        labelUseCase.getResources(request: request, dataType: [IssueLabel].self) { (result) in
            switch result {
            case .success(let labels):
                self.selectedLabels = []
                self.labelsDidLoad(labels)
            case .failure(let error):
                self.presentErrorAlert(error: error) {
                    self.fetchLabels()
                }
            }
        }
    }
    
    private func assigneeDidLoad(_ users: [User]) {
        titleLabel.text = "담당자"
        let cellIdentifier = String(describing: AssigneeTableViewCell.self)
        configureTableView(cellIdentifier)
        self.dataSource = GeneralTableViewDataSource(models: users, selectedModels: selectedUsers, reuseIdentifier: cellIdentifier) { (user, cell) in
            let addButton = cell.addButton()
            addButton.addTarget(self, action: #selector(self.selectItem), for: .touchUpInside)
            let assigneeCell = cell as! AssigneeTableViewCell
            assigneeCell.accessoryView = addButton
            assigneeCell.configureData(user)
        }
        itemSelectionTableView.dataSource = dataSource
        itemSelectionTableView.reloadData()
    }
    
    private func labelsDidLoad(_ labels: [IssueLabel]) {
        titleLabel.text = "레이블"
        let cellIdentifier = String(describing: LabelTableViewCell.self)
        configureTableView(cellIdentifier)
        self.dataSource = GeneralTableViewDataSource(models: labels, selectedModels: selectedLabels, reuseIdentifier: cellIdentifier) { (label, cell) in
            let addButton = cell.addButton()
            addButton.addTarget(self, action: #selector(self.selectItem), for: .touchUpInside)
            let labelCell = cell as! LabelTableViewCell
            labelCell.accessoryView = addButton
            labelCell.configureData(label)
        }
        itemSelectionTableView.dataSource = dataSource
        itemSelectionTableView.reloadData()
    }
    
    private func milestoneDidLoad(_ milestones: [Milestone]) {
        titleLabel.text = "마일스톤"
        let cellIdentifier = String(describing: MilestoneTableViewCell.self)
        configureTableView(cellIdentifier)
        self.dataSource = GeneralTableViewDataSource(models: milestones, selectedModels: selectedMilestones, reuseIdentifier: cellIdentifier) { (milestone, cell) in
            let addButton = cell.addButton()
            addButton.addTarget(self, action: #selector(self.selectItem), for: .touchUpInside)
            let milestoneCell = cell as! MilestoneTableViewCell
            milestoneCell.accessoryView = addButton
            milestoneCell.configureData(milestone)
        }
        itemSelectionTableView.dataSource = dataSource
        itemSelectionTableView.reloadData()
    }
    
    @objc func selectItem() {
        //TODO:- 선택한 동작
    }
    
    private func configure() {
        configureUI()
        configureUseCase()
    }
    
    private func configureUseCase() {
        labelUseCase = LabelsUseCase()
        milestoneUseCase = MilestoneUseCase()
    }
    
    private func configureTableView(_ cellIdentifier: String) {
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        itemSelectionTableView.register(nib, forCellReuseIdentifier: cellIdentifier)
    }
    
    private func configureUI() {
        itemSelectionTableView.roundCorner(cornerRadius: 12.0)
        itemSelectionTableView.drawShadow(color: .black, offset: CGSize(width: 1, height: 1), radius: 4, opacity: 0.3)
    }
    
    @IBAction func cancelButtonDidTap(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

// MARK:- Error Alert

extension ItemSelectionViewController {
    private func presentErrorAlert(error: Error, handler: @escaping () -> Void) {
        let alertController = ErrorAlertController(
            title: nil,
            message: error.localizedDescription,
            preferredStyle: .alert)
        alertController.configure(actionTitle: "재요청") { (_) in
            handler()
        }
        alertController.configure(actionTitle: "확인") { (_) in
            return
        }
        self.present(alertController, animated: true)
    }
}
