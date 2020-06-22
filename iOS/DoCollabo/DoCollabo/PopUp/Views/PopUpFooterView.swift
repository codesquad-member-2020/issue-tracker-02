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
    func resetButtonDidTap()
    func submitButtonDidTap()
}

final class PopUpFooterView: UIView {
    
    @IBOutlet var frameView: UIView!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    weak var delegate: PopUpFooterViewActionDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func hideSupplementaryButtons() {
        resetButton.isHidden = true
        cancelButton.isHidden = true
    }
    
    private func configure() {
        Bundle.main.loadNibNamed(String(describing: Self.self), owner: self, options: nil)
        addSubview(frameView)
        frameView.frame = self.bounds
        frameView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    @IBAction func tapResetButton(_ sender: UIButton) {
        delegate?.resetButtonDidTap()
    }
    
    @IBAction func cancelButtonDidTap(_ sender: UIButton) {
        delegate?.cancelButtonDidTap()
    }
    
    @IBAction func tapSubmitButton(_ sender: UIButton) {
        delegate?.submitButtonDidTap()
    }
}
