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
        hideSecondaryButton()
        configureSecondLevelBackgroundView()
    }
    
    private func configurePalette() {
        palette = ColorPicker()
        palette.backgroundColor = .white
        palette.translatesAutoresizingMaskIntoConstraints = false
        palette.set(
            color: UIColor(displayP3Red: CGFloat.random(in: 0...1.0),
                           green: CGFloat.random(in: 0...1.0),
                           blue: CGFloat.random(in: 0...1.0), alpha: 1),
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
