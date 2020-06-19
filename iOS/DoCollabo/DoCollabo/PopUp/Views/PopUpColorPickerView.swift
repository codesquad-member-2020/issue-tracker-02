//
//  SelectColorSegmentView.swift
//  DoCollabo
//
//  Created by delma on 2020/06/15.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit

protocol ColorPickerActionDelegate: class {
    func colorPickerButtonDidTap()
    func randomButtonDidTap() -> (color: UIColor, hexString: String)
}

final class PopUpColorPickerView: UIView {
    
    @IBOutlet var frameView: UIView!
    @IBOutlet weak var hexColorLabel: UILabel!
    @IBOutlet weak var colorPickerButton: UIButton!
    
    weak var delegate: ColorPickerActionDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configureColorInfo(color: UIColor?, hexString: String?) {
        hexColorLabel.text = hexString
        colorPickerButton.backgroundColor = color
    }
    
    private func configure() {
        Bundle.main.loadNibNamed(String(describing: Self.self), owner: self, options: nil)
        addSubview(frameView)
        frameView.frame = self.bounds
        configureUI()
    }
    
    private func configureUI() {
        colorPickerButton.roundCorner(cornerRadius: 12.0)
    }
    
    @IBAction func pickRandomeColor(_ sender: UIButton) {
        let colorInfo = delegate?.randomButtonDidTap()
        configureColorInfo(color: colorInfo?.color, hexString: colorInfo?.hexString)
    }
    
    @IBAction func colorPickerButtonDidTap(_ sender: UIButton) {
        delegate?.colorPickerButtonDidTap()
    }
}
