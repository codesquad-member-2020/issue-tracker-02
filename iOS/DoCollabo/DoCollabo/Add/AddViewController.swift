//
//  AddViewController.swift
//  DoCollabo
//
//  Created by delma on 2020/06/15.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var contentsView: UIView!
    @IBOutlet weak var contentsStackView: UIStackView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UILabel!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        configureUI()
        configureBackgroundView()
    }
    
    private func configureUI() {
        contentsView.roundCorner(cornerRadius: 12.0)
    }
    
    private func configureBackgroundView() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        backgroundView.addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pressCancelButton(_ sender: UIButton) {
        dismissView()
    }
    
}
