//
//  GeneralTableViewDataSource.swift
//  DoCollabo
//
//  Created by delma on 2020/06/23.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

class GeneralTableViewDataSource<Model>: NSObject, UITableViewDataSource {
    typealias CellConfigurator = (Model, UITableViewCell) -> Void
    
    private var sections = ["선택된", "선택되지 않은"]
    private var models: [Model]
    private var selectedModels: [Model]
    private let reuseIdentifier: String
    private let cellConfigurator: CellConfigurator
    
    init(models: [Model],
         selectedModels: [Model],
         reuseIdentifier: String,
         cellConfigurator: @escaping CellConfigurator) {
        self.models = models
        self.selectedModels = selectedModels
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? selectedModels.count : models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        if indexPath.section == 0 {
            cellConfigurator(selectedModels[indexPath.row], cell)
        } else {
         cellConfigurator(models[indexPath.row], cell)
        }
        return cell
    }
}
