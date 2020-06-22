//
//  AssigneeTableViewDataSource.swift
//  DoCollabo
//
//  Created by delma on 2020/06/22.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class AssigneeTableViewDataSource: NSObject, UITableViewDataSource {
    
    private var users: [User]!
    
    init(users: [User]) {
        self.users = users
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AssigneeTableViewCell.self), for: indexPath) as! AssigneeTableViewCell
        cell.accessoryView = cell.addButton()
        cell.configureData(users[indexPath.row])
        return cell
    }
}
