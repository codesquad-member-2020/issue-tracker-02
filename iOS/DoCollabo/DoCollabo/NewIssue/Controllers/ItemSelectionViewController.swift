//
//  ItemSelectionViewController.swift
//  DoCollabo
//
//  Created by delma on 2020/06/22.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class ItemSelectionViewController: UIViewController {

    @IBOutlet weak var itemSelectionTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        configureUI()
    }
    
    private func configureUI() {
        itemSelectionTableView.roundCorner(cornerRadius: 12.0)
        itemSelectionTableView.drawShadow(color: .black, offset: CGSize(width: 1, height: 1), radius: 4, opacity: 0.3)
    }
    
    @IBAction func cancelButtonDidTap(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

extension ItemSelectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
