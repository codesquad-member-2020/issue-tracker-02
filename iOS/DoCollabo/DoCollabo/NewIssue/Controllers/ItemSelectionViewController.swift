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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func assigneeDidLoad(_ users: [User]) {
        titleLabel.text = "담당자"
        let cellIdentifier = String(describing: AssigneeTableViewCell.self)
        configureTableView(cellIdentifier)
        self.dataSource = GeneralTableViewDataSource(models: users, reuseIdentifier: cellIdentifier) { (user, cell) in
            let addButton = cell.addButton()
            addButton.addTarget(self, action: #selector(self.selectItem), for: .touchUpInside)
            let assigneeCell = cell as! AssigneeTableViewCell
            assigneeCell.accessoryView = addButton
            assigneeCell.configureData(user)
        }
        itemSelectionTableView.dataSource = dataSource
    }
    
    @objc func selectItem() {
        //TODO:- 선택한 동작
    }
    
    private func configure() {
        configureUI()
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
