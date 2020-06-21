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
