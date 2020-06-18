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
    
    func configurePalette() {
        configure()
        palette = ColorPicker()
        palette.translatesAutoresizingMaskIntoConstraints = false
        palette.set(
            color: UIColor(displayP3Red: 1.0, green: 1.0, blue: 0, alpha: 1),
            colorSpace: .sRGB)
        configureContentView(palette)
        configureSecondLevelBackgroundView()
    }
}

extension ColorPickerViewController {
    override func cancelButtonDidTap() {
        dismiss(animated: false, completion: nil)
    }
}
