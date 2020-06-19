//
//  ColorPickerViewController.swift
//  DoCollabo
//
//  Created by delma on 2020/06/18.
//  Copyright © 2020 delma. All rights reserved.
//

import UIKit
import Colorful

final class ColorPickerViewController: PopUpViewController {
    
    private var palette: ColorPicker!
    private var selectedColor: String!
    
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
        selectedColor = palette.color.hexString
        palette.addTarget(self, action: #selector(self.handleColorChanged(_:)), for: .valueChanged)
        handleColorChanged(palette)
    }
    
    @objc func handleColorChanged(_ palette: ColorPicker) {
        selectedColor = palette.color.hexString
    }
}

extension ColorPickerViewController {
    override func cancelButtonDidTap() {
        dismiss(animated: false, completion: nil)
    }
    
    override func submitButtonDidTap() {
        dismiss(animated: false, completion: nil)
    }
}
