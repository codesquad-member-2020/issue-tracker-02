//
//  IssueAddViewController.swift
//  DoCollabo
//
//  Created by delma on 2020/06/22.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

class NewIssueViewController: UIViewController {

    @IBOutlet weak var titleHeaderView: TitleHeaderView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var markDownSegmentedControl: UISegmentedControl!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        configureUI()
    }

    private func configureUI() {
        titleHeaderView.titleLabel.text = "새 이슈"
        titleHeaderView.changeUI(titleSize: 34, backgroundColor: .white)
        backgroundView.roundCorner(cornerRadius: 16.0)
        backgroundView.drawShadow(color: .black, offset: CGSize(width: 1, height: 1), radius: 4, opacity: 0.3)
    }
}
