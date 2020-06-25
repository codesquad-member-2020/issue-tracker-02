//
//  ColorPickerViewController.swift
//  DoCollabo
//
//  Created by delma on 2020/06/18.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit
import Colorful

protocol ColorPickerViewControllerDelegate: class {
    func SubmitButtonDidTap(color: UIColor)
}

final class ColorPickerViewController: PopUpViewController {
    
    private var palette: ColorPicker!
    private var selectedColor: UIColor!
    
    weak var delegate: ColorPickerViewControllerDelegate?
    
    func configureColorPickerView(_ color: UIColor) {
        configure()
        configurePalette(color)
        configureSelectedColorString()
        hideSupplementaryButtons()
        configureSecondLevelBackgroundView()
    }
    
    private func configurePalette(_ color: UIColor) {
        palette = ColorPicker()
        palette.backgroundColor = .tertiarySystemBackground
        palette.translatesAutoresizingMaskIntoConstraints = false
        configureContentView(palette)
        palette.set(color: color, colorSpace: .sRGB)
    }
    
    private func configureSelectedColorString() {
        selectedColor = palette.color
        palette.addTarget(self, action: #selector(self.handleColorChanged(_:)), for: .valueChanged)
        handleColorChanged(palette)
    }
    
    @objc func handleColorChanged(_ palette: ColorPicker) {
        selectedColor = palette.color
    }
}

// MARK:- overriding

extension ColorPickerViewController {
    override func cancelButtonDidTap() {
        dismiss(animated: false, completion: nil)
    }
    
    override func submitButtonDidTap() {
        dismiss(animated: false, completion: nil)
        delegate?.SubmitButtonDidTap(color: selectedColor)
    }
}
