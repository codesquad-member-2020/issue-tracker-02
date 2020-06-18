//
//  ButtonStackView.swift
//  DoCollabo
//
//  Created by delma on 2020/06/18.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

class ButtonStackView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    var delegate: ButtonStackActionDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
           Bundle.main.loadNibNamed("ButtonStackView", owner: self, options: nil)
           addSubview(contentView)
           contentView.frame = self.bounds
           contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    @IBAction func tapResetButton(_ sender: UIButton) {
    }
    
    @IBAction func tapCancelButton(_ sender: UIButton) {
        delegate?.close()
    }
    
    @IBAction func tapSubmitButton(_ sender: UIButton) {
    }
    
}
