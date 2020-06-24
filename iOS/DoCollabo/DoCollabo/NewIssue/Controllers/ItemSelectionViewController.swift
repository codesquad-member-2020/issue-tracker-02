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
    
    private var users: [User]!
    private var labels: [IssueLabel]!
    private var milestones: [Milestone]!
    
    private var selectedUsers: [User] = [] {
        didSet {
            assigneeDidLoad()
        }
    }
    private var selectedLabels: [IssueLabel] = [] {
        didSet {
            labelsDidLoad()
        }
    }
    private var selectedMilestones: [Milestone] = [] {
        didSet {
            milestoneDidLoad()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func fetchAssigneeStub() {
        let stubUsers = AssigneesStub.users
        users = stubUsers
        assigneeDidLoad()
    }
    
    func fetchMilestones() {
        let request = MilestoneRequest().asURLRequest()
        milestoneUseCase.getResources(request: request, dataType: [Milestone].self) { (result) in
            switch result {
            case .success(let milestones):
                self.milestones = milestones
                self.milestoneDidLoad()
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
                self.labels = labels
                self.labelsDidLoad()
            case .failure(let error):
                self.presentErrorAlert(error: error) {
                    self.fetchLabels()
                }
            }
        }
    }
    
    private func assigneeDidLoad() {
        titleLabel.text = "담당자"
        let cellIdentifier = String(describing: AssigneeTableViewCell.self)
        configureTableView(cellIdentifier)
        self.dataSource = GeneralTableViewDataSource(models: users, selectedModels: selectedUsers, reuseIdentifier: cellIdentifier) { (user, cell) in
            let assigneeCell = cell as! AssigneeTableViewCell
            if self.users.contains(user) {
                let addButton = cell.addButton()
                addButton.addTarget(self, action: #selector(self.selectUser), for: .touchUpInside)
                assigneeCell.accessoryView = addButton
            }else {
                let removeButton = cell.cancelButton()
                removeButton.addTarget(self, action: #selector(self.deselectUser(_:)), for: .touchUpInside)
                assigneeCell.accessoryView = removeButton
            }
            assigneeCell.configureData(user)
        }
        itemSelectionTableView.dataSource = dataSource
        itemSelectionTableView.reloadData()
    }
    
    private func labelsDidLoad() {
        titleLabel.text = "레이블"
        let cellIdentifier = String(describing: LabelTableViewCell.self)
        configureTableView(cellIdentifier)
        self.dataSource = GeneralTableViewDataSource(models: labels, selectedModels: selectedLabels, reuseIdentifier: cellIdentifier) { (label, cell) in
            let labelCell = cell as! LabelTableViewCell
            if self.labels.contains(label) {
                let addButton = cell.addButton()
                addButton.addTarget(self, action: #selector(self.selectLabel), for: .touchUpInside)
                labelCell.accessoryView = addButton
            }else {
                let removeButton = cell.cancelButton()
                removeButton.addTarget(self, action: #selector(self.deselectLabel(_:)), for: .touchUpInside)
                labelCell.accessoryView = removeButton
            }
            labelCell.configureData(label)
        }
        itemSelectionTableView.dataSource = dataSource
        itemSelectionTableView.reloadData()
    }
    
    private func milestoneDidLoad() {
        titleLabel.text = "마일스톤"
        let cellIdentifier = String(describing: MilestoneTableViewCell.self)
        configureTableView(cellIdentifier)
        self.dataSource = GeneralTableViewDataSource(models: milestones, selectedModels: selectedMilestones, reuseIdentifier: cellIdentifier) { (milestone, cell) in
            let milestoneCell = cell as! MilestoneTableViewCell
            if self.milestones.contains(milestone) {
                let addButton = cell.addButton()
                addButton.addTarget(self, action: #selector(self.selectMilestone), for: .touchUpInside)
                milestoneCell.accessoryView = addButton
            }else {
                let removeButton = cell.cancelButton()
                removeButton.addTarget(self, action: #selector(self.deselectMilestone(_:)), for: .touchUpInside)
                milestoneCell.accessoryView = removeButton
            }
            milestoneCell.configureData(milestone)
        }
        itemSelectionTableView.dataSource = dataSource
        itemSelectionTableView.reloadData()
    }
    
    //MARK:- select
    
    @objc func selectUser(_ button: UIButton) {
        guard let indexPath = location(at: button) else { return }
        let user = users[indexPath.row]
        guard let index = users.firstIndex(of: user) else { return }
        users.remove(at: index)
        selectedUsers.append(user)
    }
    
    @objc func selectLabel(_ button: UIButton) {
        guard let indexPath = location(at: button) else { return }
        let label = labels[indexPath.row]
        guard let index = labels.firstIndex(of: label) else { return }
        labels.remove(at: index)
        selectedLabels.append(label)
    }
    
    @objc func selectMilestone(_ button: UIButton) {
        guard let indexPath = location(at: button) else { return }
        let milestone = milestones[indexPath.row]
        guard let index = milestones.firstIndex(of: milestone) else { return }
        milestones.remove(at: index)
        selectedMilestones.append(milestone)
    }
    
    //MARK:- deselect
    
    @objc func deselectUser(_ button: UIButton) {
        guard let indexPath = location(at: button) else { return }
        let user = selectedUsers[indexPath.row]
        guard let index = selectedUsers.firstIndex(of: user) else { return }
        users.append(user)
        selectedUsers.remove(at: index)
    }
    
    @objc func deselectLabel(_ button: UIButton) {
        guard let indexPath = location(at: button) else { return }
        let label = selectedLabels[indexPath.row]
        guard let index = selectedLabels.firstIndex(of: label) else { return }
        labels.append(label)
        selectedLabels.remove(at: index)
    }
    
    @objc func deselectMilestone(_ button: UIButton) {
        guard let indexPath = location(at: button) else { return }
        let milestone = selectedMilestones[indexPath.row]
        guard let index = selectedMilestones.firstIndex(of: milestone) else { return }
        milestones.append(milestone)
        selectedMilestones.remove(at: index)
    }
    
    private func location(at button: UIButton) -> IndexPath? {
        let location = button.convert(button.bounds.origin, to: self.itemSelectionTableView)
        guard let indexPath = self.itemSelectionTableView.indexPathForRow(at: location) else { return nil }
        return indexPath
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
