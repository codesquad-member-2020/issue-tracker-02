//
//  ButtonStackView.swift
//  DoCollabo
//
//  Created by delma on 2020/06/18.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

protocol PopUpFooterViewActionDelegate: class {
    func cancelButtonDidTap()
}

final class PopUpFooterView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    var delegate: PopUpFooterViewActionDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        Bundle.main.loadNibNamed(String(describing: Self.self), owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    @IBAction func tapResetButton(_ sender: UIButton) {
    }
    
    @IBAction func cancelButtonDidTap(_ sender: UIButton) {
        delegate?.cancelButtonDidTap()
    }
    
    @IBAction func tapSubmitButton(_ sender: UIButton) {
    }
}
