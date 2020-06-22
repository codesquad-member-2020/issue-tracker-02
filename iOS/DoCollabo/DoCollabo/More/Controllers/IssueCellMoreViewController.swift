//
//  IssueCellMoreViewController.swift
//  DoCollabo
//
//  Created by Cory Kim on 2020/06/23.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

final class IssueCellMoreViewController: MoreViewController {
    
    func configureIssueCellMoreViewController(with issue: Issue) {
        configureMoreViewController()
        configureTitle(issue.title)
    }
}
