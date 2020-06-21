//
//  ColorPickerViewController.swift
//  DoCollabo
//
//  Created by delma on 2020/06/18.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit
import Colorful

protocol ColorPickDelegate: class {
    func pass(colorInfo: (color: UIColor, hexString: String))
}

final class ColorPickerViewController: PopUpViewController {
    
    private var palette: ColorPicker!
    private var selectedColorInfo: (color: UIColor, hexString: String)!
    
    weak var delegate: ColorPickDelegate?
    
    func configureColorPickerView() {
        configure()
        configurePalette()
        hideSupplementaryButtons()
        configureSecondLevelBackgroundView()
    }
    
    private func configurePalette() {
        palette = ColorPicker()
        palette.backgroundColor = .white
        palette.translatesAutoresizingMaskIntoConstraints = false
        palette.set(
            color: UIColor().random(),
            colorSpace: .sRGB)
        configureContentView(palette)
        configureSelectedColorString()
    }
    
    private func configureSelectedColorString() {
        selectedColorInfo = (palette.color ,palette.color.hexString)
        palette.addTarget(self, action: #selector(self.handleColorChanged(_:)), for: .valueChanged)
        handleColorChanged(palette)
    }
    
    @objc func handleColorChanged(_ palette: ColorPicker) {
        selectedColorInfo = (palette.color ,palette.color.hexString)
    }
}

// MARK:- overriding

extension ColorPickerViewController {
    override func cancelButtonDidTap() {
        dismiss(animated: false, completion: nil)
    }
    
    override func submitButtonDidTap() {
        dismiss(animated: false, completion: nil)
        delegate?.pass(colorInfo: selectedColorInfo)
    }
}
