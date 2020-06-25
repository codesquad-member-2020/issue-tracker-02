//
//  ItemSelectionViewController.swift
//  DoCollabo
//
//  Created by delma on 2020/06/22.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

protocol ItemSelectionViewDelegate: class {
    func assigneesSubmitButtonDidTap(_ users: [User])
    func labelSubmitButtonDidTap(_ labels: [IssueLabel])
    func milestoneSubmitButtonDidTap(_ milestones: [Milestone])
}

final class ItemSelectionViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var itemSelectionTableView: UITableView!
    @IBOutlet weak var networkIndicator: UIActivityIndicatorView!
    
    weak var delegate: ItemSelectionViewDelegate?
    
    private var dataSource: UITableViewDataSource!
    private var labelUseCase: LabelsUseCase!
    private var milestoneUseCase: MilestoneUseCase!
    
    private var users: [User]!
    private var labels: [IssueLabel]!
    private var milestones: [Milestone]!
    
    private var selectedUsers: [User] = [] {
        didSet {
            configureAssigneeTableView()
        }
    }
    private var selectedLabels: [IssueLabel] = [] {
        didSet {
            configureLabelTableView()
        }
    }
    private var selectedMilestones: [Milestone] = [] {
        didSet {
            configureMilestoneTableView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    //MARK: - Fetch Data
    
    func fetchAssigneeStub() {
        hideTableView()
        let stubUsers = AssigneesStub.users
        users = stubUsers.filter() { !selectedUsers.contains($0) }
        configureAssigneeTableView()
        showTableView()
    }
    
    func fetchLabels() {
        hideTableView()
        let request = LabelsRequest().asURLRequest()
        labelUseCase.getResources(request: request, dataType: [IssueLabel].self) { (result) in
            switch result {
            case .success(let labels):
                self.labels = labels.filter() { !self.selectedLabels.contains($0) }
                self.configureLabelTableView()
            case .failure(let error):
                self.presentErrorAlert(error: error) {
                    self.fetchLabels()
                }
            }
            self.showTableView()
        }
    }
    
    func fetchMilestones() {
        hideTableView()
        let request = MilestoneRequest().asURLRequest()
        milestoneUseCase.getResources(request: request, dataType: [Milestone].self) { (result) in
            switch result {
            case .success(let milestones):
                self.milestones = milestones.filter() { !self.selectedMilestones.contains($0) }
                self.configureMilestoneTableView()
            case .failure(let error):
                self.presentErrorAlert(error: error) {
                    self.fetchMilestones()
                }
            }
            self.showTableView()
        }
    }
    
   
    @IBAction func cancelButtonDidTap(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func submitButtonDidTap(_ sender: UIButton) {
        if titleLabel.text == "담당자" {
            delegate?.assigneesSubmitButtonDidTap(selectedUsers)
        } else if titleLabel.text == "레이블" {
            delegate?.labelSubmitButtonDidTap(selectedLabels)
        } else if titleLabel.text == "마일스톤" {
            delegate?.milestoneSubmitButtonDidTap(selectedMilestones)
        }
        dismiss(animated: true)
    }
}

//MARK: - Configure TableViews

extension ItemSelectionViewController {
    private func configureAssigneeTableView() {
        titleLabel.text = "담당자"
        let cellIdentifier = String(describing: AssigneeTableViewCell.self)
        configureTableView(cellIdentifier)
        configureAssigneeDataSource(cellIdentifier)
        configureDataSource()
    }
    
    private func configureLabelTableView() {
        titleLabel.text = "레이블"
        let cellIdentifier = String(describing: LabelTableViewCell.self)
        configureTableView(cellIdentifier)
        configureLabelDataSource(cellIdentifier)
        configureDataSource()
    }
    
    private func configureMilestoneTableView() {
        titleLabel.text = "마일스톤"
        let cellIdentifier = String(describing: MilestoneTableViewCell.self)
        configureTableView(cellIdentifier)
        configureMilestoneDataSource(cellIdentifier)
        configureDataSource()
    }
    
    //MARK: - Configure DataSources
    
    private func configureAssigneeDataSource(_ cellIdentifier: String) {
        self.dataSource = GeneralTableViewDataSource(models: users, selectedModels: selectedUsers, reuseIdentifier: cellIdentifier) { (user, cell) in
            let assigneeCell = cell as! AssigneeTableViewCell
            if self.users.contains(user) {
                let addButton = self.configureAddButton()
                addButton.addTarget(self, action: #selector(self.selectUser), for: .touchUpInside)
                assigneeCell.accessoryView = addButton
            }else {
                let removeButton = self.configureRemoveButton()
                removeButton.addTarget(self, action: #selector(self.deselectUser(_:)), for: .touchUpInside)
                assigneeCell.accessoryView = removeButton
            }
            assigneeCell.configureData(user)
        }
    }
    
    private func configureLabelDataSource(_ cellIdentifier: String) {
        self.dataSource = GeneralTableViewDataSource(models: labels, selectedModels: selectedLabels, reuseIdentifier: cellIdentifier) { (label, cell) in
            let labelCell = cell as! LabelTableViewCell
            if self.labels.contains(label) {
                let addButton = self.configureAddButton()
                addButton.addTarget(self, action: #selector(self.selectLabel), for: .touchUpInside)
                labelCell.accessoryView = addButton
            }else {
                let removeButton = self.configureRemoveButton()
                removeButton.addTarget(self, action: #selector(self.deselectLabel(_:)), for: .touchUpInside)
                labelCell.accessoryView = removeButton
            }
            labelCell.configureData(label)
        }
    }
    
    private func configureMilestoneDataSource(_ cellIdentifier: String) {
        self.dataSource = GeneralTableViewDataSource(models: milestones, selectedModels: selectedMilestones, reuseIdentifier: cellIdentifier) { (milestone, cell) in
            let milestoneCell = cell as! MilestoneTableViewCell
            if self.milestones.contains(milestone) {
                let addButton = self.configureAddButton()
                addButton.addTarget(self, action: #selector(self.selectMilestone), for: .touchUpInside)
                milestoneCell.accessoryView = addButton
            }else {
                let removeButton = self.configureRemoveButton()
                removeButton.addTarget(self, action: #selector(self.deselectMilestone(_:)), for: .touchUpInside)
                milestoneCell.accessoryView = removeButton
            }
            milestoneCell.configureData(milestone)
        }
    }
    
    private func configureDataSource() {
        itemSelectionTableView.dataSource = dataSource
        itemSelectionTableView.reloadData()
    }
}

//MARK: - Accessory Button Actions

extension ItemSelectionViewController {
    
    private func configureAddButton() -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        button.tintColor = UIColor(named: "key.navy")
        button.sizeToFit()
        return button
    }
    
    private func configureRemoveButton() -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .lightGray
        button.sizeToFit()
        return button
    }
    
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
}

//MARK: - Animation

extension ItemSelectionViewController {
    private func hideTableView() {
        itemSelectionTableView.alpha = 0
        networkIndicator.startAnimating()
    }
    
    private func showTableView() {
        UIView.animate(
            withDuration: 0.7,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: .curveEaseOut,
            animations: {
                self.itemSelectionTableView.alpha = 1
                self.networkIndicator.alpha = 0
        }, completion: { _ in
            self.networkIndicator.stopAnimating()
        })
    }
}

//MARK: - Configurations

extension ItemSelectionViewController {
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
           itemSelectionTableView.drawShadow(
            color: .black,
            offset: CGSize(width: 1, height: 1),
            radius: 4,
            opacity: 0.3)
       }
}

// MARK:- Error Alert

extension ItemSelectionViewController {
    private func presentErrorAlert(error: Error, handler: @escaping () -> Void) {
        let alertController = NetworkErrorAlertController(
            title: nil,
            message: error.localizedDescription,
            preferredStyle: .alert)
        alertController.configureAction(title: "재요청") { (_) in
            handler()
        }
        alertController.configureAction(title: "확인") { (_) in
            return
        }
        self.present(alertController, animated: true)
    }
}
